-- Metric views for domain: annuity | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core annuity contract performance metrics including account values, surrender charges, and contract lifecycle KPIs"
  source: "`life_insurance_ecm`.`annuity`.`annuity_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the annuity contract (active, annuitized, surrendered, etc.)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of annuity contract (fixed, variable, indexed, etc.)"
    - name: "phase"
      expr: phase
      comment: "Current phase of the contract (accumulation, annuitization, payout)"
    - name: "tax_qualification_status"
      expr: tax_qualification_status
      comment: "Tax qualification status (qualified, non-qualified, IRA, 401k, etc.)"
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Whether the contract originated from a 1035 tax-free exchange"
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where the contract was issued"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the contract was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the contract was issued"
    - name: "contract_age_years"
      expr: CAST(DATEDIFF(CURRENT_DATE(), issue_date) / 365.25 AS INT)
      comment: "Age of the contract in years since issue"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT annuity_contract_id)
      comment: "Total number of unique annuity contracts"
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value across all contracts - primary AUM metric"
    - name: "avg_account_value"
      expr: AVG(CAST(account_value AS DOUBLE))
      comment: "Average account value per contract"
    - name: "total_csv"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value - liquidity available to contract owners"
    - name: "total_initial_premium"
      expr: SUM(CAST(initial_premium_amount AS DOUBLE))
      comment: "Total initial premium received across all contracts"
    - name: "avg_initial_premium"
      expr: AVG(CAST(initial_premium_amount AS DOUBLE))
      comment: "Average initial premium per contract"
    - name: "total_cost_basis"
      expr: SUM(CAST(cost_basis_amount AS DOUBLE))
      comment: "Total cost basis - tax basis for all contracts"
    - name: "total_rmd_current_year"
      expr: SUM(CAST(rmd_amount_current_year AS DOUBLE))
      comment: "Total required minimum distributions for current year - regulatory compliance metric"
    - name: "avg_surrender_charge_pct"
      expr: AVG(CAST(current_surrender_charge_pct AS DOUBLE))
      comment: "Average current surrender charge percentage across contracts"
    - name: "avg_free_withdrawal_pct"
      expr: AVG(CAST(free_withdrawal_pct AS DOUBLE))
      comment: "Average free withdrawal percentage available to contract owners"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_account_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic account value movements and reserve metrics for actuarial and financial reporting"
  source: "`life_insurance_ecm`.`annuity`.`account_value`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the account value snapshot"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation"
    - name: "contract_phase"
      expr: contract_phase
      comment: "Phase of the contract at valuation (accumulation, annuitization, payout)"
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year at time of valuation"
    - name: "product_type"
      expr: product_type
      comment: "Type of annuity product (fixed, variable, indexed)"
    - name: "is_mec"
      expr: is_mec
      comment: "Whether the contract is a Modified Endowment Contract for tax purposes"
    - name: "is_qualified_contract"
      expr: is_qualified_contract
      comment: "Whether the contract is tax-qualified"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record"
  measures:
    - name: "total_bov_account_value"
      expr: SUM(CAST(bov_account_value AS DOUBLE))
      comment: "Total beginning-of-valuation account value - starting AUM for period"
    - name: "total_eov_account_value"
      expr: SUM(CAST(eov_account_value AS DOUBLE))
      comment: "Total end-of-valuation account value - ending AUM for period"
    - name: "total_net_premium_applied"
      expr: SUM(CAST(net_premium_applied AS DOUBLE))
      comment: "Total net premium applied during valuation period - inflow metric"
    - name: "total_credited_interest"
      expr: SUM(CAST(credited_interest_amount AS DOUBLE))
      comment: "Total interest credited to contracts - investment return component"
    - name: "total_index_credit"
      expr: SUM(CAST(index_credit_amount AS DOUBLE))
      comment: "Total index-linked credits for FIA products - performance metric"
    - name: "total_gross_withdrawals"
      expr: SUM(CAST(gross_withdrawal_amount AS DOUBLE))
      comment: "Total gross withdrawals during period - outflow metric"
    - name: "total_surrender_charges"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges assessed - revenue and persistency metric"
    - name: "total_coi_charges"
      expr: SUM(CAST(coi_charge AS DOUBLE))
      comment: "Total cost of insurance charges - mortality cost metric"
    - name: "total_rider_charges"
      expr: SUM(CAST(rider_charge_total AS DOUBLE))
      comment: "Total rider charges assessed - rider revenue metric"
    - name: "total_gaap_reserves"
      expr: SUM(CAST(gaap_reserve AS DOUBLE))
      comment: "Total GAAP reserves held - financial reporting liability"
    - name: "total_statutory_reserves"
      expr: SUM(CAST(statutory_reserve AS DOUBLE))
      comment: "Total statutory reserves held - regulatory capital requirement"
    - name: "total_death_benefit"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit exposure - risk management metric"
    - name: "total_gmdb_nar"
      expr: SUM(CAST(nar_gmdb AS DOUBLE))
      comment: "Total net amount at risk for guaranteed minimum death benefit - hedging metric"
    - name: "total_living_benefit_nar"
      expr: SUM(CAST(nar_living_benefit AS DOUBLE))
      comment: "Total net amount at risk for living benefit riders - hedging metric"
    - name: "total_sub_account_gain_loss"
      expr: SUM(CAST(sub_account_gain_loss AS DOUBLE))
      comment: "Total sub-account investment gains/losses - market performance metric"
    - name: "avg_surrender_charge_rate"
      expr: AVG(CAST(surrender_charge_rate AS DOUBLE))
      comment: "Average surrender charge rate across contracts"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_benefit_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annuity benefit payment metrics for payout phase analysis and tax reporting"
  source: "`life_insurance_ecm`.`annuity`.`benefit_payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the benefit payment was made"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of benefit payment (annuity, withdrawal, death benefit, etc.)"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (pending, completed, reversed, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment delivery (ACH, check, wire, etc.)"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of recurring payments (monthly, quarterly, annual, etc.)"
    - name: "payout_phase"
      expr: payout_phase
      comment: "Phase of payout (immediate, deferred, systematic, etc.)"
    - name: "is_rmd_payment"
      expr: is_rmd_payment
      comment: "Whether payment satisfies required minimum distribution"
    - name: "is_mec_distribution"
      expr: is_mec_distribution
      comment: "Whether distribution is from a Modified Endowment Contract"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for which the payment is reported"
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT benefit_payment_id)
      comment: "Total number of benefit payments made"
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross benefit payments before withholding - primary outflow metric"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net benefit payments after withholding - actual cash outflow"
    - name: "avg_gross_payment"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross payment amount per transaction"
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable portion of payments - tax reporting metric"
    - name: "total_reportable_1099r"
      expr: SUM(CAST(reportable_amount_1099r AS DOUBLE))
      comment: "Total amount reportable on Form 1099-R - compliance metric"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld from payments"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state income tax withheld from payments"
    - name: "total_surrender_charges"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges assessed on payments - revenue metric"
    - name: "total_early_withdrawal_penalty"
      expr: SUM(CAST(early_withdrawal_penalty_amount AS DOUBLE))
      comment: "Total early withdrawal penalties assessed"
    - name: "total_investment_recovered"
      expr: SUM(CAST(investment_in_contract_recovered AS DOUBLE))
      comment: "Total investment in contract recovered through payments - cost basis tracking"
    - name: "total_exclusion_ratio_amount"
      expr: SUM(CAST(exclusion_ratio_amount AS DOUBLE))
      comment: "Total non-taxable portion of payments under exclusion ratio"
    - name: "avg_exclusion_ratio_pct"
      expr: AVG(CAST(exclusion_ratio_pct AS DOUBLE))
      comment: "Average exclusion ratio percentage across payments"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium payment metrics for sales, persistency, and cash flow analysis"
  source: "`life_insurance_ecm`.`annuity`.`annuity_premium_payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the premium payment was received"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of premium payment"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of premium payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the premium payment (pending, applied, rejected, etc.)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of premium payment (initial, additional, scheduled, etc.)"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of the premium payment (check, ACH, wire, rollover, etc.)"
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Whether payment is from a 1035 tax-free exchange"
    - name: "is_unscheduled"
      expr: is_unscheduled
      comment: "Whether payment is unscheduled/ad-hoc"
    - name: "nigo_status"
      expr: nigo_status
      comment: "Not-in-good-order status (clean, pending, resolved, etc.)"
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year when payment was received"
  measures:
    - name: "total_premium_payments"
      expr: COUNT(DISTINCT annuity_premium_payment_id)
      comment: "Total number of premium payment transactions"
    - name: "total_gross_premium"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross premium received - primary sales metric"
    - name: "total_applied_premium"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total premium applied to contracts - net inflow after loads"
    - name: "avg_gross_premium"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross premium per payment transaction"
    - name: "total_premium_load"
      expr: SUM(CAST(premium_load_amount AS DOUBLE))
      comment: "Total premium load charges assessed - revenue metric"
    - name: "total_bonus_credited"
      expr: SUM(CAST(bonus_credited_amount AS DOUBLE))
      comment: "Total premium bonus credited to contracts - acquisition cost metric"
    - name: "total_bonus_eligible"
      expr: SUM(CAST(bonus_eligible_amount AS DOUBLE))
      comment: "Total premium eligible for bonus crediting"
    - name: "total_cost_basis_contribution"
      expr: SUM(CAST(cost_basis_contribution AS DOUBLE))
      comment: "Total cost basis contribution from premiums - tax tracking metric"
    - name: "total_exchange_cost_basis"
      expr: SUM(CAST(exchange_cost_basis_received AS DOUBLE))
      comment: "Total cost basis received from 1035 exchanges"
    - name: "avg_premium_load_rate"
      expr: AVG(CAST(premium_load_amount AS DOUBLE) / NULLIF(CAST(gross_payment_amount AS DOUBLE), 0))
      comment: "Average premium load rate as percentage of gross premium"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_benefit_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Living benefit rider metrics for guaranteed withdrawal and income benefits"
  source: "`life_insurance_ecm`.`annuity`.`benefit_base`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of benefit base valuation"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation"
    - name: "rider_type"
      expr: rider_type
      comment: "Type of living benefit rider (GMWB, GMIB, GMAB, etc.)"
    - name: "benefit_base_status"
      expr: benefit_base_status
      comment: "Status of the benefit base (active, depleted, expired, etc.)"
    - name: "benefit_election_status"
      expr: benefit_election_status
      comment: "Election status of the benefit (elected, waiting, eligible, etc.)"
    - name: "in_the_money_flag"
      expr: in_the_money_flag
      comment: "Whether benefit base exceeds account value (in-the-money)"
    - name: "excess_withdrawal_flag"
      expr: excess_withdrawal_flag
      comment: "Whether excess withdrawals have been taken"
    - name: "step_up_provision"
      expr: step_up_provision
      comment: "Type of step-up provision (annual, anniversary, high-water-mark, etc.)"
  measures:
    - name: "total_benefit_bases"
      expr: COUNT(DISTINCT benefit_base_id)
      comment: "Total number of active benefit bases"
    - name: "total_current_benefit_base"
      expr: SUM(CAST(current_benefit_base AS DOUBLE))
      comment: "Total current benefit base value - guaranteed withdrawal capacity"
    - name: "total_inception_value"
      expr: SUM(CAST(inception_value AS DOUBLE))
      comment: "Total inception value of benefit bases"
    - name: "avg_current_benefit_base"
      expr: AVG(CAST(current_benefit_base AS DOUBLE))
      comment: "Average current benefit base per rider"
    - name: "total_annual_guaranteed_withdrawal"
      expr: SUM(CAST(annual_guaranteed_withdrawal AS DOUBLE))
      comment: "Total annual guaranteed withdrawal amount available - income capacity metric"
    - name: "total_cumulative_withdrawals"
      expr: SUM(CAST(cumulative_withdrawals AS DOUBLE))
      comment: "Total cumulative withdrawals taken against benefit bases"
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk for living benefits - hedging and capital metric"
    - name: "total_rollup_credits_ytd"
      expr: SUM(CAST(roll_up_credits_ytd AS DOUBLE))
      comment: "Total roll-up credits year-to-date - benefit enhancement metric"
    - name: "total_rollup_credits_inception"
      expr: SUM(CAST(roll_up_credits_inception_to_date AS DOUBLE))
      comment: "Total roll-up credits since inception"
    - name: "avg_guaranteed_withdrawal_rate"
      expr: AVG(CAST(guaranteed_withdrawal_rate AS DOUBLE))
      comment: "Average guaranteed withdrawal rate across riders"
    - name: "avg_rider_charge_rate"
      expr: AVG(CAST(rider_charge_rate AS DOUBLE))
      comment: "Average rider charge rate - pricing metric"
    - name: "avg_rollup_rate"
      expr: AVG(CAST(roll_up_rate AS DOUBLE))
      comment: "Average roll-up rate for benefit base growth"
    - name: "total_last_step_up_value"
      expr: SUM(CAST(last_step_up_value AS DOUBLE))
      comment: "Total value from most recent step-ups"
    - name: "total_max_anniversary_value"
      expr: SUM(CAST(max_anniversary_value AS DOUBLE))
      comment: "Total maximum anniversary value across benefit bases"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_withdrawal_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Withdrawal transaction metrics for persistency, surrender analysis, and cash flow management"
  source: "`life_insurance_ecm`.`annuity`.`withdrawal_transaction`"
  dimensions:
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the withdrawal"
    - name: "withdrawal_year"
      expr: YEAR(effective_date)
      comment: "Year of withdrawal"
    - name: "withdrawal_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of withdrawal"
    - name: "withdrawal_type"
      expr: withdrawal_type
      comment: "Type of withdrawal (partial, full surrender, systematic, RMD, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the withdrawal transaction"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment delivery"
    - name: "is_excess_withdrawal"
      expr: is_excess_withdrawal
      comment: "Whether withdrawal exceeds free withdrawal limit"
    - name: "is_within_free_withdrawal"
      expr: is_within_free_withdrawal
      comment: "Whether withdrawal is within free withdrawal limit"
    - name: "is_rmd_coordinated"
      expr: is_rmd_coordinated
      comment: "Whether withdrawal satisfies required minimum distribution"
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Whether withdrawal is for 1035 exchange to another contract"
  measures:
    - name: "total_withdrawals"
      expr: COUNT(DISTINCT withdrawal_transaction_id)
      comment: "Total number of withdrawal transactions"
    - name: "total_gross_withdrawal_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross withdrawal amount - primary outflow metric"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net proceeds after charges and withholding - actual cash outflow"
    - name: "avg_gross_withdrawal"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross withdrawal amount per transaction"
    - name: "total_surrender_charges"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges assessed - revenue and persistency metric"
    - name: "total_mva_adjustment"
      expr: SUM(CAST(mva_adjustment_amount AS DOUBLE))
      comment: "Total market value adjustment applied - interest rate risk metric"
    - name: "total_free_withdrawal_amount"
      expr: SUM(CAST(free_withdrawal_amount AS DOUBLE))
      comment: "Total amount withdrawn within free withdrawal limits"
    - name: "total_rmd_amount"
      expr: SUM(CAST(rmd_amount AS DOUBLE))
      comment: "Total required minimum distribution amount - compliance metric"
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable portion of withdrawals"
    - name: "total_cost_basis_recovered"
      expr: SUM(CAST(cost_basis_recovered_amount AS DOUBLE))
      comment: "Total cost basis recovered through withdrawals"
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld"
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state income tax withheld"
    - name: "avg_surrender_charge_rate"
      expr: AVG(CAST(surrender_charge_rate AS DOUBLE))
      comment: "Average surrender charge rate applied"
    - name: "avg_account_value_before"
      expr: AVG(CAST(account_value_before AS DOUBLE))
      comment: "Average account value before withdrawal"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_index_credit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Index crediting event metrics for fixed indexed annuity performance and hedging analysis"
  source: "`life_insurance_ecm`.`annuity`.`index_credit_event`"
  dimensions:
    - name: "term_end_date"
      expr: term_end_date
      comment: "End date of the index crediting term"
    - name: "credit_year"
      expr: YEAR(term_end_date)
      comment: "Year of index credit"
    - name: "credit_month"
      expr: DATE_TRUNC('MONTH', term_end_date)
      comment: "Month of index credit"
    - name: "event_status"
      expr: event_status
      comment: "Status of the crediting event"
    - name: "index_option_type"
      expr: index_option_type
      comment: "Type of index option (point-to-point, monthly average, etc.)"
    - name: "renewal_rate_flag"
      expr: renewal_rate_flag
      comment: "Whether this is a renewal rate crediting event"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this event reverses a prior credit"
    - name: "step_up_triggered"
      expr: step_up_triggered
      comment: "Whether a benefit base step-up was triggered by this credit"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for the crediting event"
  measures:
    - name: "total_credit_events"
      expr: COUNT(DISTINCT index_credit_event_id)
      comment: "Total number of index crediting events"
    - name: "total_credited_amount"
      expr: SUM(CAST(credited_amount AS DOUBLE))
      comment: "Total amount credited to contracts - FIA performance metric"
    - name: "avg_credited_amount"
      expr: AVG(CAST(credited_amount AS DOUBLE))
      comment: "Average amount credited per event"
    - name: "avg_credited_interest_rate"
      expr: AVG(CAST(credited_interest_rate AS DOUBLE))
      comment: "Average credited interest rate across events"
    - name: "avg_index_return_pct"
      expr: AVG(CAST(index_return_pct AS DOUBLE))
      comment: "Average index return percentage - market performance metric"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average cap rate applied - pricing parameter metric"
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate applied - pricing parameter metric"
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate applied - downside protection metric"
    - name: "avg_buffer_rate"
      expr: AVG(CAST(buffer_rate AS DOUBLE))
      comment: "Average buffer rate applied - risk-sharing metric"
    - name: "avg_spread_rate"
      expr: AVG(CAST(spread_rate AS DOUBLE))
      comment: "Average spread rate applied - pricing parameter metric"
    - name: "total_allocation_av_start"
      expr: SUM(CAST(allocation_av_start AS DOUBLE))
      comment: "Total allocation account value at term start"
    - name: "total_allocation_av_after"
      expr: SUM(CAST(allocation_av_after_credit AS DOUBLE))
      comment: "Total allocation account value after credit"
    - name: "total_withdrawal_adjustment"
      expr: SUM(CAST(withdrawal_adjustment_amount AS DOUBLE))
      comment: "Total withdrawal adjustments to index credits"
    - name: "avg_index_start_value"
      expr: AVG(CAST(index_start_value AS DOUBLE))
      comment: "Average index starting value"
    - name: "avg_index_end_value"
      expr: AVG(CAST(index_end_value AS DOUBLE))
      comment: "Average index ending value"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_charge_detail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee and charge detail metrics for revenue analysis and product profitability"
  source: "`life_insurance_ecm`.`annuity`.`charge_detail`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date the charge was assessed"
    - name: "charge_year"
      expr: YEAR(charge_date)
      comment: "Year of charge"
    - name: "charge_month"
      expr: DATE_TRUNC('MONTH', charge_date)
      comment: "Month of charge"
    - name: "charge_basis_type"
      expr: charge_basis_type
      comment: "Basis for charge calculation (account value, benefit base, premium, etc.)"
    - name: "charge_frequency"
      expr: charge_frequency
      comment: "Frequency of charge assessment (daily, monthly, quarterly, annual)"
    - name: "charge_status"
      expr: charge_status
      comment: "Status of the charge (assessed, waived, reversed, etc.)"
    - name: "contract_phase"
      expr: contract_phase
      comment: "Contract phase when charge was assessed"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal of a prior charge"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether the charge was waived"
    - name: "product_code"
      expr: product_code
      comment: "Product code for the contract"
  measures:
    - name: "total_charges"
      expr: COUNT(DISTINCT charge_detail_id)
      comment: "Total number of charge transactions"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount assessed - primary revenue metric"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction"
    - name: "total_charge_basis"
      expr: SUM(CAST(charge_basis_amount AS DOUBLE))
      comment: "Total charge basis amount (denominator for rate calculation)"
    - name: "avg_charge_rate"
      expr: AVG(CAST(charge_rate AS DOUBLE))
      comment: "Average charge rate applied"
    - name: "avg_annualized_charge_rate"
      expr: AVG(CAST(annualized_charge_rate AS DOUBLE))
      comment: "Average annualized charge rate - pricing metric"
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total net amount at risk associated with charges"
    - name: "total_av_before_charge"
      expr: SUM(CAST(av_before_charge AS DOUBLE))
      comment: "Total account value before charges"
    - name: "total_av_after_charge"
      expr: SUM(CAST(av_after_charge AS DOUBLE))
      comment: "Total account value after charges"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_rmd_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Required minimum distribution metrics for tax compliance and regulatory reporting"
  source: "`life_insurance_ecm`.`annuity`.`rmd_schedule`"
  dimensions:
    - name: "rmd_year"
      expr: rmd_year
      comment: "Tax year for which RMD is calculated"
    - name: "rmd_status"
      expr: rmd_status
      comment: "Status of the RMD (pending, satisfied, waived, delinquent, etc.)"
    - name: "qualified_plan_type"
      expr: qualified_plan_type
      comment: "Type of qualified plan (IRA, 401k, 403b, etc.)"
    - name: "first_rmd_year_flag"
      expr: first_rmd_year_flag
      comment: "Whether this is the first RMD year for the contract"
    - name: "april_1_deferral_elected"
      expr: april_1_deferral_elected
      comment: "Whether April 1 deferral was elected for first RMD"
    - name: "inherited_contract_flag"
      expr: inherited_contract_flag
      comment: "Whether this is an inherited contract"
    - name: "systematic_rmd_flag"
      expr: systematic_rmd_flag
      comment: "Whether systematic RMD withdrawals are set up"
    - name: "form_1099r_issued_flag"
      expr: form_1099r_issued_flag
      comment: "Whether Form 1099-R has been issued"
    - name: "form_5498_reported_flag"
      expr: form_5498_reported_flag
      comment: "Whether Form 5498 has been reported"
  measures:
    - name: "total_rmd_schedules"
      expr: COUNT(DISTINCT rmd_schedule_id)
      comment: "Total number of RMD schedules"
    - name: "total_calculated_rmd"
      expr: SUM(CAST(calculated_rmd_amount AS DOUBLE))
      comment: "Total calculated RMD amount - compliance obligation metric"
    - name: "avg_calculated_rmd"
      expr: AVG(CAST(calculated_rmd_amount AS DOUBLE))
      comment: "Average calculated RMD amount per schedule"
    - name: "total_remaining_rmd_balance"
      expr: SUM(CAST(remaining_rmd_balance AS DOUBLE))
      comment: "Total remaining RMD balance to be satisfied - compliance risk metric"
    - name: "total_ytd_distributions_applied"
      expr: SUM(CAST(ytd_distributions_applied AS DOUBLE))
      comment: "Total year-to-date distributions applied toward RMD"
    - name: "total_excise_tax_exposure"
      expr: SUM(CAST(excise_tax_exposure_amount AS DOUBLE))
      comment: "Total excise tax exposure for unsatisfied RMDs - risk metric"
    - name: "total_prior_year_end_av"
      expr: SUM(CAST(prior_year_end_av AS DOUBLE))
      comment: "Total prior year-end account value (RMD calculation basis)"
    - name: "avg_distribution_period"
      expr: AVG(CAST(distribution_period AS DOUBLE))
      comment: "Average distribution period (life expectancy factor)"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_bonus_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium bonus credit metrics for acquisition cost and DAC analysis"
  source: "`life_insurance_ecm`.`annuity`.`bonus_credit`"
  dimensions:
    - name: "credit_date"
      expr: credit_date
      comment: "Date the bonus was credited"
    - name: "credit_year"
      expr: YEAR(credit_date)
      comment: "Year of bonus credit"
    - name: "credit_month"
      expr: DATE_TRUNC('MONTH', credit_date)
      comment: "Month of bonus credit"
    - name: "bonus_status"
      expr: bonus_status
      comment: "Status of the bonus (credited, vested, recaptured, etc.)"
    - name: "bonus_type"
      expr: bonus_type
      comment: "Type of bonus (upfront, persistency, loyalty, etc.)"
    - name: "vesting_schedule_type"
      expr: vesting_schedule_type
      comment: "Type of vesting schedule (cliff, graded, immediate, etc.)"
    - name: "recapture_provision_flag"
      expr: recapture_provision_flag
      comment: "Whether bonus has recapture provisions"
    - name: "is_1035_exchange_eligible"
      expr: is_1035_exchange_eligible
      comment: "Whether bonus is eligible for 1035 exchange treatment"
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year when bonus was credited"
  measures:
    - name: "total_bonus_credits"
      expr: COUNT(DISTINCT bonus_credit_id)
      comment: "Total number of bonus credit transactions"
    - name: "total_bonus_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bonus amount credited - acquisition cost metric"
    - name: "avg_bonus_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bonus amount per credit"
    - name: "total_bonus_basis"
      expr: SUM(CAST(bonus_basis_amount AS DOUBLE))
      comment: "Total bonus basis amount (premium eligible for bonus)"
    - name: "avg_bonus_rate_pct"
      expr: AVG(CAST(bonus_rate_pct AS DOUBLE))
      comment: "Average bonus rate percentage - pricing metric"
    - name: "avg_current_vested_pct"
      expr: AVG(CAST(current_vested_pct AS DOUBLE))
      comment: "Average current vested percentage across bonuses"
    - name: "total_recaptured_amount"
      expr: SUM(CAST(recaptured_amount AS DOUBLE))
      comment: "Total bonus amount recaptured due to early surrender - persistency metric"
    - name: "total_av_before_bonus"
      expr: SUM(CAST(account_value_before AS DOUBLE))
      comment: "Total account value before bonus credit"
    - name: "total_av_after_bonus"
      expr: SUM(CAST(account_value_after AS DOUBLE))
      comment: "Total account value after bonus credit"
$$;