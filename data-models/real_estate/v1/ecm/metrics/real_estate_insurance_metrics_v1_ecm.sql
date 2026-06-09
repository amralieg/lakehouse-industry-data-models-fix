-- Metric views for domain: insurance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim performance metrics including loss amounts, reserves, and claim lifecycle KPIs for portfolio risk management and loss control steering decisions."
  source: "`real_estate_ecm`.`insurance`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (open, closed, denied, etc.) for lifecycle analysis"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (property, liability, workers comp, etc.) for loss segmentation"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage line triggering the claim for product performance analysis"
    - name: "cause_of_loss"
      expr: cause_of_loss
      comment: "Root cause of loss event for risk mitigation prioritization"
    - name: "catastrophe_code"
      expr: catastrophe_code
      comment: "CAT event identifier for catastrophe loss aggregation and reinsurance recovery"
    - name: "loss_year"
      expr: YEAR(loss_date)
      comment: "Calendar year of loss occurrence for loss trend analysis"
    - name: "loss_quarter"
      expr: CONCAT('Q', QUARTER(loss_date), '-', YEAR(loss_date))
      comment: "Quarter of loss occurrence for seasonal pattern analysis"
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year claim was reported for lag analysis and IBNR estimation"
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Whether claim involves litigation for legal cost forecasting"
    - name: "subrogation_flag"
      expr: subrogation_flag
      comment: "Whether subrogation is being pursued for recovery potential analysis"
  measures:
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Total number of claims for frequency analysis and benchmarking"
    - name: "total_incurred_loss"
      expr: SUM(CAST(total_incurred_loss AS DOUBLE))
      comment: "Total incurred loss (paid + reserves) for ultimate loss projection and reserve adequacy"
    - name: "total_paid_loss"
      expr: SUM(CAST(total_paid_loss AS DOUBLE))
      comment: "Total paid loss amount for cash flow forecasting and liquidity management"
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total outstanding reserves for balance sheet liability and capital requirement planning"
    - name: "avg_incurred_loss_per_claim"
      expr: AVG(CAST(total_incurred_loss AS DOUBLE))
      comment: "Average incurred loss per claim for severity trending and pricing adequacy assessment"
    - name: "total_subrogation_recovery"
      expr: SUM(CAST(subrogation_recovery AS DOUBLE))
      comment: "Total subrogation recoveries for net loss calculation and recovery rate analysis"
    - name: "net_incurred_loss"
      expr: SUM((CAST(total_incurred_loss AS DOUBLE)) - (CAST(subrogation_recovery AS DOUBLE)))
      comment: "Net incurred loss after subrogation recoveries for true economic loss measurement"
    - name: "litigation_claim_count"
      expr: SUM(CASE WHEN litigation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims in litigation for legal cost budgeting and settlement strategy"
    - name: "closed_claim_count"
      expr: SUM(CASE WHEN claim_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of closed claims for closure rate and adjuster productivity analysis"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy portfolio metrics including premium, insured values, and coverage limits for underwriting profitability and capacity management decisions."
  source: "`real_estate_ecm`.`insurance`.`policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current policy status (active, expired, cancelled) for in-force portfolio analysis"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of policy (property, liability, umbrella, etc.) for product mix analysis"
    - name: "coverage_class"
      expr: coverage_class
      comment: "Coverage class for risk segmentation and pricing strategy"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year policy became effective for vintage analysis and renewal cohorts"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year policy expires for renewal pipeline forecasting"
    - name: "premium_payment_frequency"
      expr: premium_payment_frequency
      comment: "Payment frequency (annual, quarterly, monthly) for cash flow modeling"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether policy auto-renews for retention rate forecasting"
    - name: "terrorism_coverage_flag"
      expr: terrorism_coverage_flag
      comment: "Whether terrorism coverage is included for TRIA compliance and exposure aggregation"
  measures:
    - name: "policy_count"
      expr: COUNT(1)
      comment: "Total number of policies for portfolio size and growth tracking"
    - name: "total_annual_premium"
      expr: SUM(CAST(annual_premium_amount AS DOUBLE))
      comment: "Total annual premium for revenue forecasting and budget planning"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value for exposure aggregation and catastrophe modeling"
    - name: "total_coverage_limit"
      expr: SUM(CAST(coverage_limit AS DOUBLE))
      comment: "Total coverage limits for capacity management and reinsurance purchasing"
    - name: "total_aggregate_limit"
      expr: SUM(CAST(aggregate_limit AS DOUBLE))
      comment: "Total aggregate limits for annual loss cap analysis and pricing adequacy"
    - name: "avg_premium_per_policy"
      expr: AVG(CAST(annual_premium_amount AS DOUBLE))
      comment: "Average premium per policy for pricing benchmarking and market positioning"
    - name: "avg_insured_value_per_policy"
      expr: AVG(CAST(insured_value AS DOUBLE))
      comment: "Average insured value per policy for portfolio quality and risk concentration assessment"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductibles for first-dollar retention and small loss filtering analysis"
    - name: "active_policy_count"
      expr: SUM(CASE WHEN policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active policies for in-force exposure and premium base calculation"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_premium`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium billing and collection metrics for revenue recognition, cash flow management, and collection efficiency steering decisions."
  source: "`real_estate_ecm`.`insurance`.`premium`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (paid, pending, overdue) for collection prioritization"
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (new, renewal, endorsement, audit) for revenue composition analysis"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for payment plan analysis and cash flow forecasting"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage line for product profitability analysis"
    - name: "billing_year"
      expr: YEAR(billing_period_start_date)
      comment: "Year of billing period for annual revenue trending"
    - name: "billing_quarter"
      expr: CONCAT('Q', QUARTER(billing_period_start_date), '-', YEAR(billing_period_start_date))
      comment: "Quarter of billing period for seasonal revenue pattern analysis"
    - name: "is_premium_financed"
      expr: is_premium_financed
      comment: "Whether premium is financed for financing penetration and default risk analysis"
    - name: "is_surplus_lines"
      expr: is_surplus_lines
      comment: "Whether premium is surplus lines for tax compliance and regulatory reporting"
  measures:
    - name: "premium_transaction_count"
      expr: COUNT(1)
      comment: "Total number of premium transactions for billing volume and operational efficiency tracking"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed premium for revenue pipeline and accounts receivable forecasting"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total collected premium for cash flow realization and liquidity management"
    - name: "total_net_premium"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium after commissions for underwriting profitability analysis"
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium_amount AS DOUBLE))
      comment: "Total earned premium for revenue recognition and loss ratio calculation"
    - name: "total_unearned_premium"
      expr: SUM(CAST(unearned_premium_amount AS DOUBLE))
      comment: "Total unearned premium for balance sheet liability and return premium exposure"
    - name: "total_broker_commission"
      expr: SUM(CAST(broker_commission_amount AS DOUBLE))
      comment: "Total broker commissions for distribution cost analysis and profitability assessment"
    - name: "avg_commission_rate"
      expr: AVG(CAST(broker_commission_rate AS DOUBLE))
      comment: "Average broker commission rate for distribution cost benchmarking"
    - name: "total_surplus_lines_tax"
      expr: SUM(CAST(surplus_lines_tax_amount AS DOUBLE))
      comment: "Total surplus lines tax for regulatory remittance and compliance tracking"
    - name: "collection_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total collections for collection efficiency and DSO calculation"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_claim_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim reserve movement and adequacy metrics for actuarial analysis, IBNR estimation, and reserve development steering decisions."
  source: "`real_estate_ecm`.`insurance`.`claim_reserve`"
  dimensions:
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current reserve status (open, closed, superseded) for active reserve tracking"
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of reserve (case, IBNR, ALAE) for reserve composition analysis"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage line for reserve adequacy by product"
    - name: "loss_category"
      expr: loss_category
      comment: "Loss category for reserve segmentation and development pattern analysis"
    - name: "is_ibnr"
      expr: is_ibnr
      comment: "Whether reserve is IBNR for incurred-but-not-reported liability estimation"
    - name: "is_cat_event"
      expr: is_cat_event
      comment: "Whether reserve is for catastrophe event for CAT reserve tracking"
    - name: "reserve_year"
      expr: YEAR(reserve_established_date)
      comment: "Year reserve was established for vintage development analysis"
    - name: "financial_period"
      expr: financial_period
      comment: "Financial reporting period for reserve movement reconciliation"
  measures:
    - name: "reserve_transaction_count"
      expr: COUNT(1)
      comment: "Total number of reserve transactions for reserve activity and adjuster workload tracking"
    - name: "total_current_reserve"
      expr: SUM(CAST(current_reserve_amount AS DOUBLE))
      comment: "Total current outstanding reserves for balance sheet liability and capital requirement"
    - name: "total_established_reserve"
      expr: SUM(CAST(established_amount AS DOUBLE))
      comment: "Total initially established reserves for reserve adequacy and development analysis"
    - name: "total_reserve_change"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Total reserve movement (increases and decreases) for reserve development trending"
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total paid against reserves for payout ratio and reserve burn rate analysis"
    - name: "total_incurred_amount"
      expr: SUM(CAST(incurred_amount AS DOUBLE))
      comment: "Total incurred (paid + outstanding) for ultimate loss estimation"
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverables for net reserve calculation and reinsurer credit risk"
    - name: "total_salvage_recoverable"
      expr: SUM(CAST(salvage_recoverable_amount AS DOUBLE))
      comment: "Total salvage recoverables for net loss reduction and recovery optimization"
    - name: "avg_reserve_per_claim"
      expr: AVG(CAST(current_reserve_amount AS DOUBLE))
      comment: "Average reserve per claim for severity benchmarking and reserve adequacy assessment"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy renewal performance metrics including retention, pricing changes, and renewal cycle efficiency for portfolio retention and pricing strategy decisions."
  source: "`real_estate_ecm`.`insurance`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status (quoted, bound, declined, lapsed) for renewal pipeline tracking"
    - name: "cycle_year"
      expr: cycle_year
      comment: "Renewal cycle year for annual retention trending"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year renewal becomes effective for cohort retention analysis"
    - name: "incumbent_carrier_retained"
      expr: incumbent_carrier_retained
      comment: "Whether incumbent carrier was retained for retention rate calculation"
    - name: "coverage_changed"
      expr: coverage_changed
      comment: "Whether coverage was modified at renewal for product evolution tracking"
    - name: "premium_finance_used"
      expr: premium_finance_used
      comment: "Whether premium financing was used for financing penetration analysis"
    - name: "coi_required"
      expr: coi_required
      comment: "Whether certificate of insurance is required for compliance tracking"
  measures:
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Total number of renewals for renewal volume and operational capacity planning"
    - name: "total_bound_premium"
      expr: SUM(CAST(bound_premium AS DOUBLE))
      comment: "Total bound renewal premium for retained revenue and growth tracking"
    - name: "total_prior_year_premium"
      expr: SUM(CAST(prior_year_premium AS DOUBLE))
      comment: "Total prior year premium for renewal base and retention rate calculation"
    - name: "total_quoted_premium"
      expr: SUM(CAST(quoted_premium AS DOUBLE))
      comment: "Total quoted premium for quote-to-bind conversion and pricing competitiveness analysis"
    - name: "total_premium_change"
      expr: SUM(CAST(premium_change_amount AS DOUBLE))
      comment: "Total premium change at renewal for rate change impact and pricing power assessment"
    - name: "avg_premium_change_pct"
      expr: AVG(CAST(premium_change_pct AS DOUBLE))
      comment: "Average premium change percentage for pricing trend and market competitiveness analysis"
    - name: "retained_renewal_count"
      expr: SUM(CASE WHEN incumbent_carrier_retained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retained renewals for retention rate calculation and customer loyalty tracking"
    - name: "bound_renewal_count"
      expr: SUM(CASE WHEN renewal_status = 'Bound' THEN 1 ELSE 0 END)
      comment: "Count of bound renewals for bind rate and sales effectiveness tracking"
    - name: "total_insured_value"
      expr: SUM(CAST(total_insured_value AS DOUBLE))
      comment: "Total insured value at renewal for exposure retention and portfolio quality analysis"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Insurance program portfolio metrics including total limits, premiums, and coverage scope for enterprise risk financing and reinsurance strategy decisions."
  source: "`real_estate_ecm`.`insurance`.`insurance_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current program status (active, expired, pending) for program lifecycle tracking"
    - name: "program_type"
      expr: program_type
      comment: "Type of insurance program (master, portfolio, project-specific) for program structure analysis"
    - name: "structure"
      expr: structure
      comment: "Program structure (traditional, captive, self-insured) for risk financing strategy analysis"
    - name: "year"
      expr: year
      comment: "Program year for annual program performance trending"
    - name: "inception_year"
      expr: YEAR(inception_date)
      comment: "Year program was incepted for program vintage analysis"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage scope for territorial exposure analysis"
    - name: "asset_class_scope"
      expr: asset_class_scope
      comment: "Asset classes covered for portfolio segmentation"
    - name: "terrorism_coverage_flag"
      expr: terrorism_coverage_flag
      comment: "Whether terrorism coverage is included for TRIA compliance and exposure tracking"
    - name: "earthquake_coverage_flag"
      expr: earthquake_coverage_flag
      comment: "Whether earthquake coverage is included for seismic risk management"
    - name: "flood_coverage_flag"
      expr: flood_coverage_flag
      comment: "Whether flood coverage is included for flood risk management"
  measures:
    - name: "program_count"
      expr: COUNT(1)
      comment: "Total number of insurance programs for program portfolio size tracking"
    - name: "total_program_premium"
      expr: SUM(CAST(total_program_premium AS DOUBLE))
      comment: "Total program premium for enterprise insurance cost and budget planning"
    - name: "total_program_limit"
      expr: SUM(CAST(total_program_limit AS DOUBLE))
      comment: "Total program limits for enterprise coverage capacity and adequacy assessment"
    - name: "total_tiv"
      expr: SUM(CAST(total_tiv AS DOUBLE))
      comment: "Total insured value across all programs for enterprise exposure aggregation and PML analysis"
    - name: "total_primary_layer_limit"
      expr: SUM(CAST(primary_layer_limit AS DOUBLE))
      comment: "Total primary layer limits for first-dollar coverage capacity analysis"
    - name: "total_self_insured_retention"
      expr: SUM(CAST(self_insured_retention AS DOUBLE))
      comment: "Total self-insured retention for enterprise risk retention and captive funding analysis"
    - name: "total_aggregate_deductible"
      expr: SUM(CAST(aggregate_deductible AS DOUBLE))
      comment: "Total aggregate deductibles for annual retention cap and loss fund planning"
    - name: "avg_program_premium"
      expr: AVG(CAST(total_program_premium AS DOUBLE))
      comment: "Average premium per program for program cost benchmarking"
    - name: "avg_program_limit"
      expr: AVG(CAST(total_program_limit AS DOUBLE))
      comment: "Average limit per program for coverage adequacy benchmarking"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`insurance_loss_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loss run performance metrics including loss ratios, claim frequency, and severity for underwriting profitability and pricing adequacy steering decisions."
  source: "`real_estate_ecm`.`insurance`.`loss_run`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Loss run report status for data completeness and submission tracking"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage line for product-level loss ratio analysis"
    - name: "asset_type"
      expr: asset_type
      comment: "Asset type for property class loss performance"
    - name: "period_years"
      expr: period_years
      comment: "Number of years covered in loss run for historical depth analysis"
    - name: "submission_purpose"
      expr: submission_purpose
      comment: "Purpose of loss run submission (renewal, new business, audit) for context analysis"
    - name: "catastrophe_losses_included"
      expr: catastrophe_losses_included
      comment: "Whether CAT losses are included for normalized loss ratio calculation"
    - name: "report_year"
      expr: YEAR(report_as_of_date)
      comment: "Year of loss run report for temporal trending"
  measures:
    - name: "loss_run_count"
      expr: COUNT(1)
      comment: "Total number of loss runs for submission volume and underwriting activity tracking"
    - name: "total_incurred_losses"
      expr: SUM(CAST(total_incurred_losses AS DOUBLE))
      comment: "Total incurred losses for ultimate loss projection and reserve adequacy"
    - name: "total_paid_losses"
      expr: SUM(CAST(total_paid_losses AS DOUBLE))
      comment: "Total paid losses for cash loss analysis and payout pattern trending"
    - name: "total_open_reserves"
      expr: SUM(CAST(total_open_reserves AS DOUBLE))
      comment: "Total open reserves for outstanding liability and reserve development analysis"
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium AS DOUBLE))
      comment: "Total earned premium for loss ratio denominator and profitability calculation"
    - name: "avg_loss_ratio"
      expr: AVG(CAST(loss_ratio AS DOUBLE))
      comment: "Average loss ratio for underwriting profitability and pricing adequacy assessment"
    - name: "total_claims_count_sum"
      expr: SUM(CAST(total_claims_count AS BIGINT))
      comment: "Total claim count across all loss runs for frequency analysis and exposure trending"
    - name: "total_open_claims_count_sum"
      expr: SUM(CAST(open_claims_count AS BIGINT))
      comment: "Total open claims for outstanding claim workload and closure rate analysis"
    - name: "total_closed_claims_count_sum"
      expr: SUM(CAST(closed_claims_count AS BIGINT))
      comment: "Total closed claims for closure efficiency and finality rate tracking"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value for exposure base and rate-on-line calculation"
$$;