-- Metric views for domain: annuity | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core annuity contract portfolio metrics covering in-force book value, premium volume, surrender exposure, and RMD obligations. Used by CFO, Chief Actuary, and Product leadership to steer portfolio growth, lapse risk, and tax-qualified exposure."
  source: "`life_insurance_ecm`.`annuity`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g., In-Force, Surrendered, Annuitized, Lapsed). Primary segmentation for portfolio health reporting."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of annuity contract (e.g., Fixed, Variable, FIA, SPIA). Drives product-line P&L and risk segmentation."
    - name: "phase"
      expr: phase
      comment: "Contract phase (Accumulation vs. Payout). Critical for reserve adequacy and cash-flow forecasting."
    - name: "tax_qualification_status"
      expr: tax_qualification_status
      comment: "Whether the contract is tax-qualified (IRA, 403b, etc.) or non-qualified. Drives RMD obligations and regulatory reporting."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "U.S. state where the contract was issued. Used for regulatory compliance, state-level reserve requirements, and market penetration analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Individual, joint, trust, or corporate ownership. Affects suitability, tax treatment, and beneficiary rules."
    - name: "payout_option"
      expr: payout_option
      comment: "Elected payout option (e.g., Life Only, Period Certain, Joint & Survivor). Drives mortality exposure and reserve duration."
    - name: "fia_index_strategy"
      expr: fia_index_strategy
      comment: "Index strategy elected for FIA contracts (e.g., S&P 500 Point-to-Point). Used to analyze crediting exposure and hedging needs."
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Indicates whether the contract originated from a 1035 tax-free exchange. Used for cost-basis tracking and replacement analysis."
    - name: "rmd_required"
      expr: rmd_required
      comment: "Whether the contract requires Required Minimum Distributions. Drives RMD compliance monitoring and operational workload."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of contract issue. Used for cohort analysis, new business trending, and persistency studies."
    - name: "issue_date_year"
      expr: YEAR(issue_date)
      comment: "Year of contract issue. Used for vintage/cohort performance analysis and surrender charge period tracking."
    - name: "surrender_charge_period_years"
      expr: surrender_charge_period_years
      comment: "Length of the surrender charge period in years. Used to segment contracts by liquidity restriction and lapse risk."
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT contract_id)
      comment: "Total number of distinct in-force annuity contracts. Baseline KPI for portfolio size and growth tracking."
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value across all contracts as of the most recent valuation. Primary AUM metric for the annuity book; drives fee revenue and reserve requirements."
    - name: "total_initial_premium"
      expr: SUM(CAST(initial_premium_amount AS DOUBLE))
      comment: "Sum of initial premium amounts at contract inception. Measures new business production volume and capital deployment."
    - name: "total_csv"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value across the portfolio. Represents the maximum immediate liquidity obligation to policyholders; key lapse-risk and liquidity-stress metric."
    - name: "total_cost_basis"
      expr: SUM(CAST(cost_basis_amount AS DOUBLE))
      comment: "Aggregate policyholder cost basis across all contracts. Used for tax reporting, gain/loss analysis, and 1099-R preparation."
    - name: "total_rmd_current_year"
      expr: SUM(CAST(rmd_amount_current_year AS DOUBLE))
      comment: "Total Required Minimum Distribution obligations for the current year across all qualified contracts. Drives IRS compliance monitoring and cash-flow planning."
    - name: "avg_account_value_per_contract"
      expr: AVG(CAST(account_value AS DOUBLE))
      comment: "Average account value per contract. Indicates average policyholder wealth level and product mix quality; used in pricing and distribution strategy."
    - name: "avg_current_surrender_charge_pct"
      expr: AVG(CAST(current_surrender_charge_pct AS DOUBLE))
      comment: "Average current surrender charge percentage across the portfolio. Measures the average liquidity restriction level; higher values indicate lower near-term lapse risk."
    - name: "avg_free_withdrawal_pct"
      expr: AVG(CAST(free_withdrawal_pct AS DOUBLE))
      comment: "Average free withdrawal percentage allowed without surrender charges. Used to estimate annual penalty-free liquidity exposure across the book."
    - name: "contracts_with_rmd_required"
      expr: COUNT(DISTINCT CASE WHEN rmd_required = TRUE THEN contract_id END)
      comment: "Number of contracts subject to Required Minimum Distributions. Drives IRS compliance workload sizing and operational planning."
    - name: "contracts_1035_exchange"
      expr: COUNT(DISTINCT CASE WHEN is_1035_exchange = TRUE THEN contract_id END)
      comment: "Number of contracts originated via 1035 tax-free exchange. Used to monitor replacement activity, suitability compliance, and cost-basis transfer accuracy."
    - name: "contracts_mva_applicable"
      expr: COUNT(DISTINCT CASE WHEN is_mva_applicable = TRUE THEN contract_id END)
      comment: "Number of contracts subject to Market Value Adjustment on surrender. Quantifies interest-rate-sensitive surrender exposure for ALM and stress testing."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_account_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic account value movement metrics capturing credited interest, charges, withdrawals, index credits, and reserve positions. Used by Actuarial, Finance, and Product teams for reserve adequacy, profitability, and guaranteed benefit exposure monitoring."
  source: "`life_insurance_ecm`.`annuity`.`account_value`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the account value valuation. Primary time axis for trend analysis and period-over-period comparisons."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation. Used for monthly reserve reporting and credited interest trend analysis."
    - name: "valuation_cycle"
      expr: valuation_cycle
      comment: "Valuation cycle identifier (e.g., Monthly, Quarterly, Annual). Used to filter and compare results across valuation frequencies."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation run (e.g., Final, Preliminary, Restated). Ensures only finalized values are used in production reporting."
    - name: "contract_phase"
      expr: contract_phase
      comment: "Phase of the contract at valuation (Accumulation or Payout). Drives reserve methodology and cash-flow projection differences."
    - name: "product_type"
      expr: product_type
      comment: "Product type (e.g., Fixed Deferred, Variable, FIA). Enables product-line profitability and reserve segmentation."
    - name: "product_code"
      expr: product_code
      comment: "Specific product code. Used for granular product-level performance attribution."
    - name: "fia_index_strategy"
      expr: fia_index_strategy
      comment: "FIA index strategy in effect at valuation. Used to analyze index crediting exposure and hedging effectiveness by strategy."
    - name: "is_mec"
      expr: is_mec
      comment: "Whether the contract is a Modified Endowment Contract. MECs have different tax treatment; used for compliance and 1099-R reporting segmentation."
    - name: "is_qualified_contract"
      expr: is_qualified_contract
      comment: "Whether the contract is tax-qualified. Drives RMD obligations and tax reporting segmentation."
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year at valuation. Used for surrender charge period analysis and lapse rate cohort studies."
  measures:
    - name: "total_eov_account_value"
      expr: SUM(CAST(eov_account_value AS DOUBLE))
      comment: "Total end-of-valuation-period account value. Primary AUM metric for the period; drives fee revenue, reserve calculations, and policyholder statements."
    - name: "total_bov_account_value"
      expr: SUM(CAST(bov_account_value AS DOUBLE))
      comment: "Total beginning-of-valuation-period account value. Used as the denominator for period return and growth rate calculations."
    - name: "total_credited_interest"
      expr: SUM(CAST(credited_interest_amount AS DOUBLE))
      comment: "Total interest credited to policyholder accounts during the period. Key cost-of-funds metric for fixed and FIA products; directly impacts spread margin."
    - name: "total_index_credits"
      expr: SUM(CAST(index_credit_amount AS DOUBLE))
      comment: "Total index credits applied to FIA contracts. Measures the cost of index-linked crediting; compared against hedge income for FIA profitability."
    - name: "total_coi_charges"
      expr: SUM(CAST(coi_charge AS DOUBLE))
      comment: "Total cost-of-insurance charges deducted from account values. Represents mortality charge revenue; used in profitability and pricing adequacy analysis."
    - name: "total_rider_charges"
      expr: SUM(CAST(rider_charge_total AS DOUBLE))
      comment: "Total rider charges (GMWB, GMIB, GMAB, GMDB) deducted from account values. Key fee revenue stream; compared against reserve increases for rider profitability."
    - name: "total_gross_withdrawals"
      expr: SUM(CAST(gross_withdrawal_amount AS DOUBLE))
      comment: "Total gross withdrawal amounts processed. Measures policyholder liquidity utilization; high values signal lapse pressure or systematic withdrawal activity."
    - name: "total_surrender_charges_collected"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges collected. Revenue from early contract terminations; also an indicator of lapse activity and policyholder behavior."
    - name: "total_net_premium_applied"
      expr: SUM(CAST(net_premium_applied AS DOUBLE))
      comment: "Total net premium applied to contracts during the period. Measures new money inflows net of loads; key new business production metric."
    - name: "total_gaap_reserve"
      expr: SUM(CAST(gaap_reserve AS DOUBLE))
      comment: "Total GAAP reserve held against annuity liabilities. Core financial reporting metric; compared against account value to assess reserve adequacy."
    - name: "total_statutory_reserve"
      expr: SUM(CAST(statutory_reserve AS DOUBLE))
      comment: "Total statutory reserve held. Regulatory solvency metric; compared against admitted assets for RBC and solvency ratio calculations."
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit exposure across the portfolio. Measures net amount at risk for GMDB; drives reinsurance and hedging decisions."
    - name: "total_gmwb_benefit_base"
      expr: SUM(CAST(gmwb_benefit_base AS DOUBLE))
      comment: "Total GMWB benefit base across all contracts. Measures the guaranteed withdrawal exposure; key input for GMWB reserve and hedge program sizing."
    - name: "total_gmib_benefit_base"
      expr: SUM(CAST(gmib_benefit_base AS DOUBLE))
      comment: "Total GMIB benefit base. Measures guaranteed income benefit exposure; used for GMIB reserve adequacy and annuitization rate assumption validation."
    - name: "total_gmab_benefit_base"
      expr: SUM(CAST(gmab_benefit_base AS DOUBLE))
      comment: "Total GMAB benefit base. Measures guaranteed accumulation benefit exposure; used for GMAB reserve and maturity benefit projection."
    - name: "total_nar_gmdb"
      expr: SUM(CAST(nar_gmdb AS DOUBLE))
      comment: "Total net amount at risk for GMDB riders. Represents the excess of guaranteed death benefit over account value; drives reinsurance cession and hedge notional sizing."
    - name: "total_nar_living_benefit"
      expr: SUM(CAST(nar_living_benefit AS DOUBLE))
      comment: "Total net amount at risk for living benefit riders (GMWB/GMIB/GMAB). Measures the in-the-money exposure of living benefit guarantees; critical for hedge program and reserve stress testing."
    - name: "total_csv"
      expr: SUM(CAST(csv AS DOUBLE))
      comment: "Total cash surrender value across all contracts at valuation. Represents maximum immediate liquidity obligation; used in ALM and liquidity stress scenarios."
    - name: "avg_fia_participation_rate"
      expr: AVG(CAST(fia_participation_rate AS DOUBLE))
      comment: "Average FIA participation rate across index strategies. Measures the average share of index return credited to policyholders; used in pricing adequacy and competitive positioning analysis."
    - name: "avg_fia_cap_rate"
      expr: AVG(CAST(fia_cap_rate AS DOUBLE))
      comment: "Average FIA cap rate across index strategies. Measures the average maximum crediting rate; used to assess competitiveness and option budget utilization."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium payment flow metrics covering new money inflows, bonus crediting, 1035 exchange volume, NIGO rates, and AML flags. Used by Finance, Compliance, and Distribution leadership to monitor new business quality, operational efficiency, and regulatory risk."
  source: "`life_insurance_ecm`.`annuity`.`annuity_premium_payment`"
  dimensions:
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of premium payment. Primary time dimension for new business production trending and cash-flow forecasting."
    - name: "payment_date_year"
      expr: YEAR(payment_date)
      comment: "Year of premium payment. Used for annual production reporting and year-over-year growth analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of premium payment (e.g., Initial, Subsequent, Rollover). Distinguishes new business from in-force premium activity."
    - name: "payment_status"
      expr: payment_status
      comment: "Processing status of the payment (e.g., Applied, Pending, Reversed). Used to filter to clean applied payments for financial reporting."
    - name: "payment_source"
      expr: payment_source
      comment: "Source channel of the payment (e.g., ACH, Wire, Check). Used for operational efficiency and fraud risk analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of scheduled payments (e.g., Monthly, Annual, Single). Distinguishes single-premium from flexible-premium product flows."
    - name: "is_1035_exchange"
      expr: is_1035_exchange
      comment: "Whether the payment is a 1035 tax-free exchange. Used to monitor replacement activity and suitability compliance."
    - name: "nigo_status"
      expr: nigo_status
      comment: "Not-In-Good-Order status of the payment submission. Used to track application quality and operational rework rates."
    - name: "tax_qualification_code"
      expr: tax_qualification_code
      comment: "Tax qualification code of the premium (e.g., IRA, Non-Qualified). Drives contribution limit monitoring and tax reporting."
    - name: "aml_review_flag"
      expr: aml_review_flag
      comment: "Whether the payment was flagged for AML review. Used by Compliance to monitor suspicious activity rates and SAR filing obligations."
    - name: "contract_year"
      expr: contract_year
      comment: "Contract year in which the payment was received. Used to analyze premium persistency and subsequent premium patterns by contract vintage."
  measures:
    - name: "total_gross_premium_received"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross premium received across all payment types. Primary new business production KPI; drives revenue, reserve, and capital planning."
    - name: "total_applied_premium"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total premium successfully applied to contracts. Net of NIGO and pending items; the operationally clean inflow figure used for AUM and reserve calculations."
    - name: "total_premium_load"
      expr: SUM(CAST(premium_load_amount AS DOUBLE))
      comment: "Total premium load charges deducted at payment. Represents front-end fee revenue; used in product profitability and pricing adequacy analysis."
    - name: "total_bonus_credited"
      expr: SUM(CAST(bonus_credited_amount AS DOUBLE))
      comment: "Total premium bonus amounts credited to policyholders. Represents the cost of premium bonus features; compared against expected persistency to assess bonus program ROI."
    - name: "total_cost_basis_contribution"
      expr: SUM(CAST(cost_basis_contribution AS DOUBLE))
      comment: "Total cost basis contributed via premium payments. Used for tax reporting accuracy and 1099-R taxable amount calculations."
    - name: "total_1035_exchange_basis_received"
      expr: SUM(CAST(exchange_cost_basis_received AS DOUBLE))
      comment: "Total cost basis received from 1035 exchange source contracts. Used to validate cost-basis transfer accuracy and assess deferred gain exposure on exchanged contracts."
    - name: "total_payments"
      expr: COUNT(DISTINCT annuity_premium_payment_id)
      comment: "Total number of premium payment transactions. Operational volume metric for staffing, processing capacity, and SLA monitoring."
    - name: "nigo_payment_count"
      expr: COUNT(DISTINCT CASE WHEN nigo_status IS NOT NULL AND nigo_status != 'Resolved' THEN annuity_premium_payment_id END)
      comment: "Number of payments in NIGO (Not-In-Good-Order) status. Measures application quality and operational rework burden; high NIGO rates indicate distribution training gaps."
    - name: "aml_flagged_payment_count"
      expr: COUNT(DISTINCT CASE WHEN aml_review_flag = TRUE THEN annuity_premium_payment_id END)
      comment: "Number of payments flagged for AML review. Compliance KPI for suspicious activity monitoring; drives SAR filing workload and regulatory risk exposure."
    - name: "total_scheduled_premium"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Total scheduled premium amounts. Used to measure premium persistency — the gap between scheduled and applied premium indicates lapse or payment failure rates."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_withdrawal_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Withdrawal activity metrics covering gross outflows, surrender charges, excess withdrawals, RMD coordination, and tax withholding. Used by Finance, Actuarial, and Compliance to monitor lapse risk, benefit base erosion, and IRS distribution compliance."
  source: "`life_insurance_ecm`.`annuity`.`withdrawal_transaction`"
  dimensions:
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of withdrawal effective date. Primary time dimension for outflow trending and lapse rate analysis."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year of withdrawal. Used for annual lapse and withdrawal rate reporting."
    - name: "withdrawal_type"
      expr: withdrawal_type
      comment: "Type of withdrawal (e.g., Full Surrender, Partial, Systematic, RMD). Drives lapse rate calculation and cash-flow projection segmentation."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the withdrawal (e.g., Completed, Pending, Reversed). Used to filter to finalized transactions for financial reporting."
    - name: "is_excess_withdrawal"
      expr: is_excess_withdrawal
      comment: "Whether the withdrawal exceeded the GMWB/GMIB free withdrawal amount. Excess withdrawals reduce benefit bases; critical for living benefit exposure monitoring."
    - name: "is_within_free_withdrawal"
      expr: is_within_free_withdrawal
      comment: "Whether the withdrawal was within the contractual free withdrawal allowance. Used to segment penalty-free vs. surrender-charge-bearing outflows."
    - name: "is_rmd_coordinated"
      expr: is_rmd_coordinated
      comment: "Whether the withdrawal was coordinated with an RMD schedule. Used for IRS compliance monitoring and RMD satisfaction tracking."
    - name: "distribution_code"
      expr: distribution_code
      comment: "IRS distribution code for 1099-R reporting (e.g., 1=Early, 7=Normal). Used for tax reporting accuracy and compliance audits."
    - name: "swp_status"
      expr: swp_status
      comment: "Systematic Withdrawal Plan status. Used to segment recurring vs. ad-hoc withdrawals and forecast future outflow patterns."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment disbursement (e.g., ACH, Check, Wire). Used for operational efficiency and fraud risk analysis."
    - name: "surrender_charge_year"
      expr: surrender_charge_year
      comment: "Contract year at time of withdrawal for surrender charge calculation. Used to analyze surrender activity by charge period cohort."
  measures:
    - name: "total_gross_withdrawals"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross withdrawal amounts. Primary outflow KPI; used in lapse rate calculation, ALM cash-flow projections, and policyholder behavior studies."
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net proceeds paid to policyholders after surrender charges, taxes, and adjustments. Represents actual cash outflow; used in liquidity management."
    - name: "total_surrender_charges_collected"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges collected on withdrawals. Revenue from early terminations; also a measure of lapse activity within the surrender charge period."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld on distributions. Used for IRS Form 945 reporting and withholding compliance monitoring."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state income tax withheld on distributions. Used for state tax remittance compliance and multi-state reporting."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable portion of withdrawals. Used for 1099-R reporting accuracy and tax liability estimation for policyholders."
    - name: "total_cost_basis_recovered"
      expr: SUM(CAST(cost_basis_recovered_amount AS DOUBLE))
      comment: "Total cost basis recovered through withdrawals. Used to track remaining investment in contract and validate exclusion ratio calculations."
    - name: "total_mva_adjustment"
      expr: SUM(CAST(mva_adjustment_amount AS DOUBLE))
      comment: "Total Market Value Adjustment applied on withdrawals. Measures interest-rate-driven adjustment impact on policyholder proceeds; used in ALM and rate sensitivity analysis."
    - name: "total_free_withdrawal_amount"
      expr: SUM(CAST(free_withdrawal_amount AS DOUBLE))
      comment: "Total amount withdrawn within the free withdrawal allowance. Measures penalty-free liquidity utilization; used to calibrate free withdrawal assumption in lapse models."
    - name: "total_rmd_withdrawal_amount"
      expr: SUM(CAST(rmd_amount AS DOUBLE))
      comment: "Total RMD amounts distributed through withdrawal transactions. Used to verify RMD satisfaction and IRS compliance across the qualified contract portfolio."
    - name: "withdrawal_transaction_count"
      expr: COUNT(DISTINCT withdrawal_transaction_id)
      comment: "Total number of withdrawal transactions. Operational volume metric for processing capacity planning and SLA monitoring."
    - name: "excess_withdrawal_count"
      expr: COUNT(DISTINCT CASE WHEN is_excess_withdrawal = TRUE THEN withdrawal_transaction_id END)
      comment: "Number of withdrawals that exceeded the GMWB/GMIB free withdrawal amount. Measures benefit base erosion events; high counts signal policyholder behavior risk for living benefit reserves."
    - name: "full_surrender_gross_amount"
      expr: SUM(CAST(CASE WHEN withdrawal_type = 'Full Surrender' THEN gross_amount ELSE 0 END AS DOUBLE))
      comment: "Total gross amount from full contract surrenders. Measures lapse-driven outflows; used to calculate dollar-weighted lapse rates and validate lapse assumptions."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_benefit_base`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guaranteed living benefit base metrics covering GMWB, GMIB, GMAB benefit base levels, roll-up credits, step-up activity, and in-the-money exposure. Used by Actuarial and Risk Management to monitor guaranteed benefit obligations, hedge program sizing, and reserve adequacy."
  source: "`life_insurance_ecm`.`annuity`.`benefit_base`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of benefit base valuation. Primary time axis for guaranteed benefit exposure trending."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation. Used for monthly reserve and hedge notional reporting."
    - name: "rider_type"
      expr: rider_type
      comment: "Type of guaranteed benefit rider (GMWB, GMIB, GMAB, GMDB). Primary segmentation for benefit exposure analysis and reserve attribution."
    - name: "benefit_base_status"
      expr: benefit_base_status
      comment: "Current status of the benefit base (e.g., Active, Terminated, Exhausted). Used to filter to active obligations for reserve calculations."
    - name: "benefit_election_status"
      expr: benefit_election_status
      comment: "Whether the benefit has been elected for payout. Distinguishes accumulation-phase from payout-phase guaranteed benefit exposure."
    - name: "in_the_money_flag"
      expr: in_the_money_flag
      comment: "Whether the benefit base exceeds the current account value (in-the-money). Critical risk indicator; in-the-money contracts represent real economic liability for the insurer."
    - name: "excess_withdrawal_flag"
      expr: excess_withdrawal_flag
      comment: "Whether excess withdrawals have occurred, reducing the benefit base. Used to monitor benefit base erosion and validate policyholder behavior assumptions."
    - name: "step_up_provision"
      expr: step_up_provision
      comment: "Type of step-up provision on the rider (e.g., Annual, Quarterly). Used to analyze step-up frequency and its impact on benefit base growth."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the benefit base. Used for multi-currency portfolio aggregation and FX risk reporting."
    - name: "inception_date_year"
      expr: YEAR(inception_date)
      comment: "Year the benefit base was established. Used for vintage analysis of guaranteed benefit cohorts and roll-up period tracking."
  measures:
    - name: "total_current_benefit_base"
      expr: SUM(CAST(current_benefit_base AS DOUBLE))
      comment: "Total current guaranteed benefit base across all active riders. Primary measure of guaranteed benefit obligation; drives reserve and hedge program sizing."
    - name: "total_inception_value"
      expr: SUM(CAST(inception_value AS DOUBLE))
      comment: "Total benefit base value at rider inception. Used as baseline to measure benefit base growth from roll-ups and step-ups over time."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk across all benefit bases (benefit base minus account value where positive). Measures the economic cost of guarantees; primary input for hedge notional and reserve stress testing."
    - name: "total_annual_guaranteed_withdrawal"
      expr: SUM(CAST(annual_guaranteed_withdrawal AS DOUBLE))
      comment: "Total annual guaranteed withdrawal amounts across all GMWB benefit bases. Measures the annual cash-flow obligation from guaranteed withdrawal riders; used in ALM and liquidity planning."
    - name: "total_cumulative_withdrawals"
      expr: SUM(CAST(cumulative_withdrawals AS DOUBLE))
      comment: "Total cumulative withdrawals taken against benefit bases. Used to measure benefit base utilization and validate withdrawal rate assumptions in GMWB models."
    - name: "total_roll_up_credits_ytd"
      expr: SUM(CAST(roll_up_credits_ytd AS DOUBLE))
      comment: "Total year-to-date roll-up credits applied to benefit bases. Measures the cost of roll-up guarantees in the current year; used in pricing adequacy and reserve sensitivity analysis."
    - name: "total_roll_up_credits_inception_to_date"
      expr: SUM(CAST(roll_up_credits_inception_to_date AS DOUBLE))
      comment: "Total cumulative roll-up credits since rider inception. Measures the total benefit base enhancement from roll-up provisions; used to assess long-term cost of guaranteed growth features."
    - name: "total_max_anniversary_value"
      expr: SUM(CAST(max_anniversary_value AS DOUBLE))
      comment: "Total maximum anniversary value (high-water mark) across benefit bases. Measures the ratchet step-up exposure; used to quantify the cost of anniversary step-up provisions."
    - name: "total_gmab_guaranteed_floor"
      expr: SUM(CAST(gmab_guaranteed_floor AS DOUBLE))
      comment: "Total GMAB guaranteed floor value across all GMAB riders. Measures the minimum account value guarantee obligation at maturity; used for GMAB reserve and hedge sizing."
    - name: "in_the_money_benefit_base_count"
      expr: COUNT(DISTINCT CASE WHEN in_the_money_flag = TRUE THEN benefit_base_id END)
      comment: "Number of benefit bases currently in-the-money (benefit base exceeds account value). Key risk concentration metric; high counts indicate elevated reserve and hedge costs."
    - name: "avg_guaranteed_withdrawal_rate"
      expr: AVG(CAST(guaranteed_withdrawal_rate AS DOUBLE))
      comment: "Average guaranteed withdrawal rate across GMWB benefit bases. Used to assess the average annual withdrawal obligation as a percentage of benefit base; input for GMWB cash-flow projections."
    - name: "avg_roll_up_rate"
      expr: AVG(CAST(roll_up_rate AS DOUBLE))
      comment: "Average roll-up rate across benefit bases with roll-up provisions. Measures the average guaranteed growth rate of benefit bases; used in pricing adequacy and competitive analysis."
    - name: "avg_rider_charge_rate"
      expr: AVG(CAST(rider_charge_rate AS DOUBLE))
      comment: "Average rider charge rate across all benefit bases. Used to assess whether rider fee revenue is adequate relative to the cost of guarantees."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_benefit_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annuity benefit payment metrics covering gross and net payment volumes, tax withholding, RMD distributions, and 1099-R reportable amounts. Used by Finance, Actuarial, and Tax Operations to monitor payout phase cash flows, tax compliance, and reserve run-off."
  source: "`life_insurance_ecm`.`annuity`.`benefit_payment`"
  dimensions:
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of benefit payment. Primary time dimension for payout cash-flow trending and reserve run-off analysis."
    - name: "payment_date_year"
      expr: YEAR(payment_date)
      comment: "Year of benefit payment. Used for annual payout volume reporting and 1099-R tax year reconciliation."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of benefit payment (e.g., Annuity, Death Benefit, Surrender, GMWB). Drives reserve attribution and cash-flow projection segmentation."
    - name: "payment_status"
      expr: payment_status
      comment: "Processing status of the payment (e.g., Paid, Pending, Reversed). Used to filter to completed payments for financial reporting."
    - name: "payout_phase"
      expr: payout_phase
      comment: "Phase of payout (e.g., Annuitization, Systematic Withdrawal, Death Benefit). Used to segment reserve run-off by payout type."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of benefit payments (Monthly, Quarterly, Annual). Used for cash-flow timing analysis and operational scheduling."
    - name: "distribution_code"
      expr: distribution_code
      comment: "IRS distribution code for 1099-R reporting. Used for tax compliance monitoring and distribution type analysis."
    - name: "is_rmd_payment"
      expr: is_rmd_payment
      comment: "Whether the payment satisfies an RMD obligation. Used for IRS RMD compliance monitoring and excise tax exposure tracking."
    - name: "is_mec_distribution"
      expr: is_mec_distribution
      comment: "Whether the payment is from a Modified Endowment Contract. MEC distributions have different tax treatment; used for compliance and 1099-R accuracy."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year of the distribution for 1099-R reporting. Used for year-end tax reporting reconciliation."
    - name: "contract_qualification_type"
      expr: contract_qualification_type
      comment: "Tax qualification type of the contract (Qualified vs. Non-Qualified). Drives tax treatment of distributions and withholding requirements."
  measures:
    - name: "total_gross_payments"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross benefit payments made. Primary payout cash-flow KPI; used in reserve run-off analysis, ALM, and policyholder obligation monitoring."
    - name: "total_net_payments"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net benefit payments after tax withholding. Represents actual cash disbursed to policyholders; used in liquidity management and bank reconciliation."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable portion of benefit payments. Used for 1099-R Box 2a reporting accuracy and tax liability estimation."
    - name: "total_federal_tax_withheld"
      expr: SUM(CAST(federal_tax_withheld_amount AS DOUBLE))
      comment: "Total federal income tax withheld on benefit payments. Used for IRS Form 945 remittance and withholding compliance monitoring."
    - name: "total_state_tax_withheld"
      expr: SUM(CAST(state_tax_withheld_amount AS DOUBLE))
      comment: "Total state income tax withheld. Used for multi-state tax remittance compliance and state-level reporting."
    - name: "total_reportable_1099r_amount"
      expr: SUM(CAST(reportable_amount_1099r AS DOUBLE))
      comment: "Total 1099-R reportable distribution amounts. Primary tax reporting KPI; used to reconcile IRS filings and validate tax reporting system accuracy."
    - name: "total_surrender_charges_on_payments"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges deducted from benefit payments. Measures surrender charge revenue from payout-phase terminations."
    - name: "total_early_withdrawal_penalties"
      expr: SUM(CAST(early_withdrawal_penalty_amount AS DOUBLE))
      comment: "Total IRS 10% early withdrawal penalties on distributions. Compliance metric for pre-59½ distributions; used to assess policyholder tax exposure and suitability."
    - name: "total_exclusion_ratio_amount"
      expr: SUM(CAST(exclusion_ratio_amount AS DOUBLE))
      comment: "Total non-taxable return-of-basis amounts via exclusion ratio. Used to validate cost-basis recovery calculations and 1099-R Box 2a accuracy."
    - name: "payment_count"
      expr: COUNT(DISTINCT benefit_payment_id)
      comment: "Total number of benefit payment transactions. Operational volume metric for payment processing capacity and SLA monitoring."
    - name: "rmd_payment_count"
      expr: COUNT(DISTINCT CASE WHEN is_rmd_payment = TRUE THEN benefit_payment_id END)
      comment: "Number of payments that satisfy RMD obligations. Used to verify RMD compliance across the qualified contract portfolio and track IRS deadline adherence."
    - name: "avg_gross_payment_amount"
      expr: AVG(CAST(gross_payment_amount AS DOUBLE))
      comment: "Average gross benefit payment amount. Used to monitor payment size trends and detect anomalies in payout schedules."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_index_credit_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FIA index crediting event metrics covering credited amounts, index returns, cap/floor/participation rate utilization, and step-up triggers. Used by Product, Actuarial, and Hedging teams to monitor FIA crediting costs, hedge effectiveness, and option budget utilization."
  source: "`life_insurance_ecm`.`annuity`.`index_credit_event`"
  dimensions:
    - name: "term_end_date_month"
      expr: DATE_TRUNC('MONTH', term_end_date)
      comment: "Month of index crediting term end. Primary time dimension for crediting event analysis and hedge settlement timing."
    - name: "term_end_date_year"
      expr: YEAR(term_end_date)
      comment: "Year of index crediting term end. Used for annual crediting cost reporting and option budget reconciliation."
    - name: "index_option_type"
      expr: index_option_type
      comment: "Type of index option strategy (e.g., Point-to-Point, Monthly Average, Daily Average). Used to analyze crediting cost and hedge cost by option type."
    - name: "event_status"
      expr: event_status
      comment: "Status of the crediting event (e.g., Final, Pending, Reversed). Used to filter to finalized events for financial reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the crediting event was reversed. Used to identify and exclude reversed events from production reporting."
    - name: "step_up_triggered"
      expr: step_up_triggered
      comment: "Whether the crediting event triggered a benefit base step-up. Used to measure step-up frequency and its impact on guaranteed benefit exposure."
    - name: "renewal_rate_flag"
      expr: renewal_rate_flag
      comment: "Whether the crediting event used a renewal (vs. initial) rate. Used to analyze renewal rate competitiveness and policyholder retention risk."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year of the index credit. Used for tax reporting and year-end reconciliation."
  measures:
    - name: "total_credited_amount"
      expr: SUM(CAST(credited_amount AS DOUBLE))
      comment: "Total index credits applied to policyholder accounts. Primary FIA crediting cost KPI; compared against hedge income to measure FIA spread margin."
    - name: "avg_index_return_pct"
      expr: AVG(CAST(index_return_pct AS DOUBLE))
      comment: "Average gross index return percentage across crediting events. Used to assess the underlying index performance environment and its impact on crediting costs."
    - name: "avg_credited_interest_rate"
      expr: AVG(CAST(credited_interest_rate AS DOUBLE))
      comment: "Average net credited interest rate after cap/floor/participation adjustments. Measures the average policyholder crediting rate; used in competitive positioning and option budget analysis."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average cap rate across FIA crediting events. Used to monitor cap rate trends and assess competitiveness of the FIA product offering."
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate across FIA crediting events. Measures the average share of index return passed to policyholders; used in option budget and pricing adequacy analysis."
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate (minimum crediting rate) across FIA events. Used to quantify the cost of the floor guarantee and its impact on option budget."
    - name: "avg_spread_rate"
      expr: AVG(CAST(spread_rate AS DOUBLE))
      comment: "Average spread rate deducted from index return. Used to analyze the spread component of FIA crediting and its contribution to company margin."
    - name: "total_contract_av_after_credit"
      expr: SUM(CAST(contract_av_after_credit AS DOUBLE))
      comment: "Total contract account value after index credits are applied. Used to measure the AUM impact of crediting events and validate account value movement."
    - name: "step_up_event_count"
      expr: COUNT(DISTINCT CASE WHEN step_up_triggered = TRUE THEN index_credit_event_id END)
      comment: "Number of crediting events that triggered a benefit base step-up. Measures step-up frequency; high counts increase guaranteed benefit exposure and reserve costs."
    - name: "crediting_event_count"
      expr: COUNT(DISTINCT index_credit_event_id)
      comment: "Total number of index crediting events processed. Operational volume metric for FIA crediting cycle management and hedge settlement reconciliation."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_contract_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract-level valuation snapshot metrics covering account value, reserves, guaranteed benefit bases, and surrender values. Used by Actuarial, Finance, and Risk Management for period-end reserve reporting, GAAP/Statutory reconciliation, and guaranteed benefit exposure monitoring."
  source: "`life_insurance_ecm`.`annuity`.`contract_valuation`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Valuation date of the contract snapshot. Primary time axis for reserve trending and period-end reporting."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation. Used for monthly reserve and AUM reporting."
    - name: "valuation_cycle"
      expr: valuation_cycle
      comment: "Valuation cycle (Monthly, Quarterly, Annual). Used to filter and compare results across reporting frequencies."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation (Final, Preliminary, Restated). Used to ensure only finalized valuations are used in production reporting."
    - name: "contract_phase"
      expr: contract_phase
      comment: "Contract phase at valuation (Accumulation vs. Payout). Drives reserve methodology and cash-flow projection differences."
    - name: "product_code"
      expr: product_code
      comment: "Product code at valuation. Used for product-level reserve attribution and profitability analysis."
    - name: "tax_qualification_type"
      expr: tax_qualification_type
      comment: "Tax qualification type (Qualified vs. Non-Qualified). Used for RMD obligation segmentation and tax reporting."
    - name: "gmwb_rider_active"
      expr: gmwb_rider_active
      comment: "Whether a GMWB rider is active on the contract. Used to segment guaranteed withdrawal benefit exposure."
    - name: "gmib_rider_active"
      expr: gmib_rider_active
      comment: "Whether a GMIB rider is active on the contract. Used to segment guaranteed income benefit exposure."
    - name: "gmab_rider_active"
      expr: gmab_rider_active
      comment: "Whether a GMAB rider is active on the contract. Used to segment guaranteed accumulation benefit exposure."
    - name: "is_mec"
      expr: is_mec
      comment: "Whether the contract is a Modified Endowment Contract at valuation. Used for tax compliance segmentation."
  measures:
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value across all contracts at valuation. Primary AUM metric for the period; drives fee revenue, reserve calculations, and policyholder statements."
    - name: "total_gaap_reserve"
      expr: SUM(CAST(gaap_reserve AS DOUBLE))
      comment: "Total GAAP reserve held against annuity liabilities. Core financial reporting metric; compared against account value to assess GAAP reserve adequacy."
    - name: "total_statutory_reserve"
      expr: SUM(CAST(statutory_reserve AS DOUBLE))
      comment: "Total statutory reserve held. Regulatory solvency metric; compared against admitted assets for RBC ratio calculations."
    - name: "total_cash_surrender_value"
      expr: SUM(CAST(cash_surrender_value AS DOUBLE))
      comment: "Total cash surrender value across all contracts. Represents maximum immediate liquidity obligation; used in ALM and liquidity stress scenarios."
    - name: "total_death_benefit"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit exposure across the portfolio. Measures GMDB and base death benefit obligations; drives reinsurance and hedging decisions."
    - name: "total_gmwb_benefit_base"
      expr: SUM(CAST(gmwb_benefit_base AS DOUBLE))
      comment: "Total GMWB benefit base at valuation. Measures guaranteed withdrawal exposure; key input for GMWB reserve and hedge program sizing."
    - name: "total_gmib_benefit_base"
      expr: SUM(CAST(gmib_benefit_base AS DOUBLE))
      comment: "Total GMIB benefit base at valuation. Measures guaranteed income benefit exposure; used for GMIB reserve adequacy and annuitization rate assumption validation."
    - name: "total_gmab_benefit_base"
      expr: SUM(CAST(gmab_benefit_base AS DOUBLE))
      comment: "Total GMAB benefit base at valuation. Measures guaranteed accumulation benefit exposure; used for GMAB reserve and maturity benefit projection."
    - name: "total_nar_gmdb"
      expr: SUM(CAST(nar_gmdb AS DOUBLE))
      comment: "Total net amount at risk for GMDB at valuation. Represents excess of guaranteed death benefit over account value; primary input for GMDB reserve and reinsurance sizing."
    - name: "total_nar_gmwb"
      expr: SUM(CAST(nar_gmwb AS DOUBLE))
      comment: "Total net amount at risk for GMWB at valuation. Measures in-the-money GMWB exposure; critical for hedge notional and reserve stress testing."
    - name: "total_surrender_charge_amount"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges applicable at valuation. Measures the aggregate surrender charge protection on the book; used in lapse risk and liquidity analysis."
    - name: "total_market_value_adjustment"
      expr: SUM(CAST(market_value_adjustment AS DOUBLE))
      comment: "Total market value adjustment applicable at valuation. Measures interest-rate-driven MVA impact on surrender values; used in ALM and rate sensitivity analysis."
    - name: "total_accrued_rider_charges"
      expr: SUM(CAST(accrued_rider_charges AS DOUBLE))
      comment: "Total accrued but unpaid rider charges at valuation. Used for revenue accrual accuracy and rider profitability analysis."
    - name: "avg_credited_interest_rate"
      expr: AVG(CAST(credited_interest_rate AS DOUBLE))
      comment: "Average credited interest rate across all contracts at valuation. Used to monitor the cost of crediting relative to earned investment yield; key spread margin input."
    - name: "total_ytd_withdrawals"
      expr: SUM(CAST(ytd_withdrawals AS DOUBLE))
      comment: "Total year-to-date withdrawals across all contracts at valuation. Used to measure annual policyholder liquidity utilization and validate lapse/withdrawal assumptions."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_tax_free_exchange`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "1035 tax-free exchange metrics covering exchange volume, deferred gain, cost basis transfers, NIGO rates, and AML compliance. Used by Compliance, Finance, and Distribution leadership to monitor replacement activity, suitability risk, and tax reporting accuracy."
  source: "`life_insurance_ecm`.`annuity`.`tax_free_exchange`"
  dimensions:
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of exchange effective date. Primary time dimension for exchange volume trending and replacement activity monitoring."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year of exchange. Used for annual replacement activity reporting and regulatory filing reconciliation."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of 1035 exchange (Full, Partial). Used to distinguish complete replacements from partial transfers."
    - name: "exchange_status"
      expr: exchange_status
      comment: "Current status of the exchange (e.g., Completed, Pending, Cancelled). Used to filter to completed exchanges for financial reporting."
    - name: "nigo_status"
      expr: nigo_status
      comment: "NIGO status of the exchange submission. Used to track application quality and operational rework rates for exchange processing."
    - name: "aml_review_status"
      expr: aml_review_status
      comment: "AML review status of the exchange. Used by Compliance to monitor suspicious activity and SAR filing obligations on large exchanges."
    - name: "source_contract_type"
      expr: source_contract_type
      comment: "Type of the source contract being exchanged (e.g., Life Insurance, Annuity). Used to analyze exchange source product mix and replacement patterns."
    - name: "partial_exchange_indicator"
      expr: partial_exchange_indicator
      comment: "Whether the exchange is a partial transfer. Partial exchanges have specific IRS rules; used for tax reporting compliance monitoring."
    - name: "is_mec_new_contract"
      expr: is_mec_new_contract
      comment: "Whether the new contract resulting from the exchange is a MEC. Used for MEC compliance monitoring and policyholder tax impact assessment."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year of the exchange. Used for 1099-R and Form 5498 reporting reconciliation."
  measures:
    - name: "total_exchange_count"
      expr: COUNT(DISTINCT tax_free_exchange_id)
      comment: "Total number of 1035 exchange transactions. Primary replacement activity volume metric; used for suitability compliance monitoring and distribution channel analysis."
    - name: "total_source_account_value_exchanged"
      expr: SUM(CAST(source_account_value_at_exchange AS DOUBLE))
      comment: "Total account value transferred from source contracts via 1035 exchange. Measures the dollar volume of replacement activity; used in new business production and suitability analysis."
    - name: "total_cost_basis_transferred"
      expr: SUM(CAST(cost_basis_transferred AS DOUBLE))
      comment: "Total cost basis transferred from source contracts. Used to validate cost-basis continuity in 1035 exchanges and ensure accurate tax reporting on the new contract."
    - name: "total_gain_deferred"
      expr: SUM(CAST(gain_deferred AS DOUBLE))
      comment: "Total deferred gain transferred via 1035 exchanges. Measures the aggregate tax liability deferred by policyholders; used for tax exposure analysis and policyholder communication."
    - name: "total_source_surrender_charges"
      expr: SUM(CAST(source_surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges incurred on source contracts at exchange. Used to assess the cost of replacement to policyholders and evaluate suitability of exchange recommendations."
    - name: "nigo_exchange_count"
      expr: COUNT(DISTINCT CASE WHEN nigo_status IS NOT NULL AND nigo_status != 'Resolved' THEN tax_free_exchange_id END)
      comment: "Number of exchanges in NIGO status. Measures exchange application quality and operational rework burden; high NIGO rates indicate distribution training gaps."
    - name: "mec_new_contract_count"
      expr: COUNT(DISTINCT CASE WHEN is_mec_new_contract = TRUE THEN tax_free_exchange_id END)
      comment: "Number of exchanges resulting in a MEC on the new contract. Compliance KPI; MEC status has adverse tax consequences for policyholders and requires specific disclosures."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`annuity_rmd_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Required Minimum Distribution compliance metrics covering RMD obligations, satisfaction rates, excise tax exposure, and systematic distribution setup. Used by Tax Operations and Compliance to monitor IRS RMD deadline adherence and minimize excise tax risk."
  source: "`life_insurance_ecm`.`annuity`.`rmd_schedule`"
  dimensions:
    - name: "rmd_year"
      expr: rmd_year
      comment: "Tax year of the RMD obligation. Primary segmentation for annual RMD compliance reporting."
    - name: "rmd_status"
      expr: rmd_status
      comment: "Current status of the RMD (e.g., Satisfied, Pending, Overdue). Used to identify non-compliant accounts requiring immediate action."
    - name: "qualified_plan_type"
      expr: qualified_plan_type
      comment: "Type of qualified plan (e.g., Traditional IRA, 403b, 401a). Used to apply correct RMD rules and distribution period tables by plan type."
    - name: "systematic_rmd_flag"
      expr: systematic_rmd_flag
      comment: "Whether the RMD is set up for systematic (automatic) distribution. Used to measure automation rate and identify accounts requiring manual intervention."
    - name: "first_rmd_year_flag"
      expr: first_rmd_year_flag
      comment: "Whether this is the first RMD year for the contract. Used to identify accounts requiring April 1 deadline monitoring."
    - name: "inherited_contract_flag"
      expr: inherited_contract_flag
      comment: "Whether the contract is inherited (beneficiary RMD rules apply). Inherited contracts have different distribution rules; used for compliance segmentation."
    - name: "rmd_due_date_month"
      expr: DATE_TRUNC('MONTH', rmd_due_date)
      comment: "Month of RMD due date. Used for deadline monitoring and operational workload planning."
  measures:
    - name: "total_calculated_rmd_amount"
      expr: SUM(CAST(calculated_rmd_amount AS DOUBLE))
      comment: "Total calculated RMD obligations across all qualified contracts. Primary IRS compliance metric; measures the aggregate distribution requirement for the year."
    - name: "total_ytd_distributions_applied"
      expr: SUM(CAST(ytd_distributions_applied AS DOUBLE))
      comment: "Total year-to-date distributions applied toward RMD obligations. Used to measure RMD satisfaction progress and identify accounts at risk of non-compliance."
    - name: "total_remaining_rmd_balance"
      expr: SUM(CAST(remaining_rmd_balance AS DOUBLE))
      comment: "Total remaining RMD balance not yet distributed. Measures the outstanding IRS obligation; high balances near year-end indicate excise tax risk."
    - name: "total_excise_tax_exposure"
      expr: SUM(CAST(excise_tax_exposure_amount AS DOUBLE))
      comment: "Total potential IRS excise tax exposure from unsatisfied RMDs. Measures the financial penalty risk from non-compliance; used to prioritize outreach and remediation efforts."
    - name: "total_prior_year_end_av"
      expr: SUM(CAST(prior_year_end_av AS DOUBLE))
      comment: "Total prior year-end account value used as RMD calculation basis. Used to validate RMD calculation accuracy and reconcile with IRS reporting."
    - name: "rmd_accounts_total"
      expr: COUNT(DISTINCT rmd_schedule_id)
      comment: "Total number of accounts with RMD obligations. Measures the operational scale of RMD compliance program."
    - name: "rmd_accounts_satisfied"
      expr: COUNT(DISTINCT CASE WHEN rmd_status = 'Satisfied' THEN rmd_schedule_id END)
      comment: "Number of RMD accounts with fully satisfied obligations. Used to calculate RMD satisfaction rate; key compliance KPI for IRS audit readiness."
    - name: "rmd_accounts_overdue"
      expr: COUNT(DISTINCT CASE WHEN rmd_status = 'Overdue' THEN rmd_schedule_id END)
      comment: "Number of RMD accounts past their due date without full satisfaction. Critical compliance alert metric; overdue accounts face IRS excise tax penalties."
    - name: "systematic_rmd_account_count"
      expr: COUNT(DISTINCT CASE WHEN systematic_rmd_flag = TRUE THEN rmd_schedule_id END)
      comment: "Number of RMD accounts set up for systematic automatic distributions. Measures automation coverage; higher rates reduce operational risk and excise tax exposure."
$$;