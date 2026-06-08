-- Metric views for domain: policy | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_in_force_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core policy portfolio metrics tracking the active book of business, face amount exposure, account value, cash surrender value, and loan utilization across the in-force policy population. Used by executives and actuaries to monitor portfolio size, risk exposure, and policyholder behavior."
  source: "`life_insurance_ecm`.`policy`.`in_force_policy`"
  dimensions:
    - name: "policy_status"
      expr: policy_status
      comment: "Current lifecycle status of the policy (e.g., Active, Lapsed, Surrendered, Matured). Primary segmentation for portfolio health analysis."
    - name: "product_type"
      expr: product_type
      comment: "Type of life insurance product (e.g., Term, Whole Life, Universal Life, Variable UL). Drives product-line performance segmentation."
    - name: "premium_mode"
      expr: premium_mode
      comment: "Frequency of premium payment (e.g., Monthly, Quarterly, Annual). Used to analyze premium collection patterns and persistency."
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction where the policy is issued. Supports geographic distribution and regulatory reporting."
    - name: "death_benefit_option"
      expr: death_benefit_option
      comment: "Death benefit option elected by the policyholder (e.g., Level, Increasing). Affects mortality exposure and reserve calculations."
    - name: "tax_qualification_status"
      expr: tax_qualification_status
      comment: "Tax qualification status of the policy (e.g., Qualified, Non-Qualified). Relevant for tax reporting and product compliance."
    - name: "mec_status_flag"
      expr: mec_status_flag
      comment: "Indicates whether the policy is classified as a Modified Endowment Contract (MEC) under IRC 7702A. Critical for tax compliance monitoring."
    - name: "reinsurance_cession_flag"
      expr: reinsurance_cession_flag
      comment: "Indicates whether the policy has been ceded to a reinsurer. Used to segment net vs. gross exposure."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of policy issue date. Enables cohort analysis and new business production trending."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the policy became effective. Used for vintage/cohort analysis of the in-force block."
    - name: "gpt_cvat_election"
      expr: gpt_cvat_election
      comment: "IRC 7702 definition election (GPT or CVAT). Affects tax compliance testing and product design analysis."
  measures:
    - name: "total_policies_in_force"
      expr: COUNT(1)
      comment: "Total number of in-force policy records. Baseline measure of portfolio size used in all executive dashboards."
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount (death benefit exposure) across all policies. Primary measure of mortality risk exposure and a key input to reinsurance and capital planning."
    - name: "total_account_value"
      expr: SUM(CAST(account_value AS DOUBLE))
      comment: "Total account value across all policies. Represents the aggregate policyholder fund balance and is a key driver of fee revenue for UL and VUL products."
    - name: "total_csv_amount"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value across all policies. Represents the maximum liquidity obligation to policyholders and is critical for ALM and liquidity risk management."
    - name: "total_modal_premium"
      expr: SUM(CAST(modal_premium AS DOUBLE))
      comment: "Total modal (scheduled) premium across all in-force policies. Proxy for expected premium revenue and persistency monitoring."
    - name: "total_policy_loan_balance"
      expr: SUM(CAST(policy_loan_balance AS DOUBLE))
      comment: "Total outstanding policy loan balance across the portfolio. Elevated loan balances signal lapse risk and reduce net death benefit exposure."
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit amount payable across all in-force policies. Represents gross mortality liability and is used in reserve adequacy and reinsurance treaty analysis."
    - name: "avg_face_amount_per_policy"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per policy. Indicates the average size of risk exposure per policy and is used to segment the portfolio by market tier."
    - name: "avg_account_value_per_policy"
      expr: AVG(CAST(account_value AS DOUBLE))
      comment: "Average account value per policy. Tracks average policyholder fund size, informing fee revenue projections and customer value segmentation."
    - name: "mec_policy_count"
      expr: COUNT(CASE WHEN mec_status_flag = TRUE THEN 1 END)
      comment: "Number of policies classified as Modified Endowment Contracts. MEC policies carry adverse tax treatment; monitoring this count is required for compliance and customer communication."
    - name: "reinsurance_ceded_policy_count"
      expr: COUNT(CASE WHEN reinsurance_cession_flag = TRUE THEN 1 END)
      comment: "Number of policies with active reinsurance cessions. Used to reconcile gross vs. net exposure and validate reinsurance treaty utilization."
    - name: "irc_7702_compliant_policy_count"
      expr: COUNT(CASE WHEN irc_7702_compliant_flag = TRUE THEN 1 END)
      comment: "Number of policies confirmed compliant with IRC 7702 life insurance tax qualification rules. Non-compliant policies create significant tax and regulatory risk."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy valuation metrics capturing account value, cash surrender value, death benefit, reserve, loan balances, and charges at the policy-valuation-date level. Used by actuaries, finance, and product management to monitor policyholder fund performance, charge adequacy, and reserve levels."
  source: "`life_insurance_ecm`.`policy`.`value`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the policy valuation snapshot. Primary time dimension for trending account value, reserves, and charges over time."
    - name: "valuation_date_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation date. Used for monthly roll-forward analysis of account values and reserves."
    - name: "valuation_basis_code"
      expr: valuation_basis_code
      comment: "Basis under which the valuation was performed (e.g., GAAP, Statutory, Tax). Enables multi-basis comparison of reserves and values."
    - name: "mec_status_flag"
      expr: mec_status_flag
      comment: "MEC status at the time of valuation. Used to segment MEC vs. non-MEC policy value pools."
    - name: "cvat_compliance_flag"
      expr: cvat_compliance_flag
      comment: "Indicates CVAT (Cash Value Accumulation Test) compliance at valuation. Non-compliant policies require corrective action."
    - name: "gpt_compliance_flag"
      expr: gpt_compliance_flag
      comment: "Indicates GPT (Guideline Premium Test) compliance at valuation. Non-compliant policies require corrective action."
    - name: "policy_anniversary_date"
      expr: policy_anniversary_date
      comment: "Policy anniversary date at the time of valuation. Used to align valuation snapshots with policy year boundaries."
  measures:
    - name: "total_av_amount"
      expr: SUM(CAST(av_amount AS DOUBLE))
      comment: "Total account value across all policy valuation records. Core measure of aggregate policyholder fund assets under management."
    - name: "total_csv_amount"
      expr: SUM(CAST(csv_amount AS DOUBLE))
      comment: "Total cash surrender value across all valuations. Represents the aggregate liquidity obligation to policyholders at the valuation date."
    - name: "total_death_benefit_amount"
      expr: SUM(CAST(death_benefit_amount AS DOUBLE))
      comment: "Total death benefit amount at valuation. Tracks gross mortality exposure over time and is used in reserve adequacy reviews."
    - name: "total_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total policy reserve amount. Primary measure of statutory and GAAP reserve adequacy; directly impacts capital requirements and regulatory filings."
    - name: "total_coi_charge_amount"
      expr: SUM(CAST(coi_charge_amount AS DOUBLE))
      comment: "Total cost-of-insurance charges deducted from policyholder accounts. Measures mortality charge revenue and is used to assess COI rate adequacy."
    - name: "total_interest_credited_amount"
      expr: SUM(CAST(interest_credited_amount AS DOUBLE))
      comment: "Total interest credited to policyholder accounts. Measures the cost of crediting guarantees and is a key driver of spread compression analysis."
    - name: "total_loan_balance_amount"
      expr: SUM(CAST(loan_balance_amount AS DOUBLE))
      comment: "Total policy loan balance at valuation. Elevated loan balances reduce net account value and increase lapse risk."
    - name: "total_surrender_charge_amount"
      expr: SUM(CAST(surrender_charge_amount AS DOUBLE))
      comment: "Total surrender charges applicable at valuation. Represents the contingent revenue from early surrenders and is used in lapse assumption modeling."
    - name: "total_rider_charge_amount"
      expr: SUM(CAST(rider_charge_amount AS DOUBLE))
      comment: "Total rider charges deducted from policyholder accounts. Measures rider fee revenue and is used to assess rider profitability."
    - name: "total_premium_ytd_amount"
      expr: SUM(CAST(premium_ytd_amount AS DOUBLE))
      comment: "Total year-to-date premium collected across all policies at valuation. Tracks premium persistency and production within the policy year."
    - name: "total_withdrawal_ytd_amount"
      expr: SUM(CAST(withdrawal_ytd_amount AS DOUBLE))
      comment: "Total year-to-date withdrawals across all policies at valuation. High withdrawal activity signals policyholder liquidity stress and lapse risk."
    - name: "total_index_credit_amount"
      expr: SUM(CAST(index_credit_amount AS DOUBLE))
      comment: "Total index credits applied to policyholder accounts (IUL products). Measures the cost of index-linked crediting strategies."
    - name: "total_nar_amount"
      expr: SUM(CAST(nar_amount AS DOUBLE))
      comment: "Total Net Amount at Risk (NAR) across all policies at valuation. NAR is the difference between death benefit and account value; it drives COI charges and reinsurance costs."
    - name: "avg_av_amount_per_policy"
      expr: AVG(CAST(av_amount AS DOUBLE))
      comment: "Average account value per policy valuation record. Used to track average policyholder fund size trends and segment by product or cohort."
    - name: "total_dac_balance_amount"
      expr: SUM(CAST(dac_balance_amount AS DOUBLE))
      comment: "Total Deferred Acquisition Cost (DAC) balance across all policies. DAC amortization is a major driver of GAAP earnings and is monitored closely by finance."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_surrender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy surrender and lapse metrics tracking voluntary termination activity, surrender proceeds, charges, taxable gains, and nonforfeiture elections. Used by product management, actuaries, and finance to monitor lapse experience, surrender charge revenue, and tax reporting obligations."
  source: "`life_insurance_ecm`.`policy`.`surrender`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of surrender transaction (e.g., Full Surrender, Partial Withdrawal, 1035 Exchange). Segments surrender activity by transaction category."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the surrender transaction (e.g., Pending, Completed, Reversed). Used to filter completed vs. in-flight surrenders."
    - name: "nonforfeiture_option_type"
      expr: nonforfeiture_option_type
      comment: "Nonforfeiture option elected at surrender (e.g., Reduced Paid-Up, Extended Term, Cash). Tracks policyholder election behavior at lapse."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used to disburse surrender proceeds (e.g., Check, EFT, 1035 Transfer). Used for operational efficiency and fraud monitoring."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the surrender became effective. Primary time dimension for lapse rate trending and seasonality analysis."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the surrender became effective. Used for annual lapse experience studies."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the surrender. Identifies drivers of policyholder termination behavior (e.g., financial hardship, competitor offer)."
    - name: "naic_compliance_flag"
      expr: naic_compliance_flag
      comment: "Indicates whether the surrender transaction is NAIC-compliant. Non-compliant surrenders require regulatory remediation."
    - name: "form_1099r_indicator"
      expr: form_1099r_indicator
      comment: "Indicates whether a 1099-R tax form is required for this surrender. Used for tax reporting completeness monitoring."
  measures:
    - name: "total_surrender_count"
      expr: COUNT(1)
      comment: "Total number of surrender transactions. Baseline measure of lapse/surrender activity volume."
    - name: "total_gross_surrender_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross surrender amount before charges and withholding. Measures the total policyholder fund outflow from surrenders."
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds AS DOUBLE))
      comment: "Total net proceeds paid to policyholders after surrender charges, loan offsets, and tax withholding. Represents actual cash outflow to policyholders."
    - name: "total_surrender_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total surrender charges collected. Surrender charges are a key revenue offset to lapse losses and are monitored for adequacy against pricing assumptions."
    - name: "total_taxable_gain_amount"
      expr: SUM(CAST(taxable_gain_amount AS DOUBLE))
      comment: "Total taxable gain recognized on surrenders. Drives 1099-R reporting obligations and is monitored for tax compliance."
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total federal and state tax withheld on surrender proceeds. Ensures withholding compliance and reconciles to IRS remittance."
    - name: "total_outstanding_loan_offset"
      expr: SUM(CAST(outstanding_loan_amount AS DOUBLE))
      comment: "Total outstanding loan amounts offset against surrender proceeds. Measures the loan recovery component of surrender transactions."
    - name: "total_free_withdrawal_amount"
      expr: SUM(CAST(free_withdrawal_amount AS DOUBLE))
      comment: "Total free withdrawal amounts taken without surrender charge. Tracks utilization of free withdrawal provisions against product design assumptions."
    - name: "total_mva_amount"
      expr: SUM(CAST(mva_amount AS DOUBLE))
      comment: "Total Market Value Adjustment (MVA) applied on surrenders. MVA amounts reflect interest rate risk transfer to policyholders on fixed annuity and UL products."
    - name: "avg_net_proceeds_per_surrender"
      expr: AVG(CAST(net_proceeds AS DOUBLE))
      comment: "Average net proceeds per surrender transaction. Indicates the average size of surrender payouts and is used to segment high-value vs. low-value lapse activity."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy loan metrics tracking loan origination, outstanding balances, interest accrual, repayment activity, and lapse risk indicators. Used by finance, actuaries, and operations to monitor loan utilization, interest income, and the risk of policy lapse due to loan over-extension."
  source: "`life_insurance_ecm`.`policy`.`loan`"
  dimensions:
    - name: "loan_type"
      expr: loan_type
      comment: "Type of policy loan (e.g., Standard, Automatic Premium Loan). Segments loan activity by origination trigger."
    - name: "loan_status"
      expr: loan_status
      comment: "Current status of the loan (e.g., Active, Repaid, Offset at Surrender). Used to filter active loan exposure."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Type of interest rate applied to the loan (e.g., Fixed, Variable). Affects interest income projections and policyholder cost analysis."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used to disburse loan proceeds (e.g., Check, EFT). Used for operational monitoring."
    - name: "origination_date_month"
      expr: DATE_TRUNC('MONTH', origination_date)
      comment: "Month of loan origination. Used to trend new loan activity and identify seasonal borrowing patterns."
    - name: "origination_date_year"
      expr: YEAR(origination_date)
      comment: "Year of loan origination. Used for vintage analysis of loan cohorts."
    - name: "apl_trigger_flag"
      expr: apl_trigger_flag
      comment: "Indicates whether the loan was triggered automatically to prevent lapse (Automatic Premium Loan). APL activity is a leading indicator of policyholder financial stress."
    - name: "taxable_event_flag"
      expr: taxable_event_flag
      comment: "Indicates whether the loan constitutes a taxable event. Used for tax compliance monitoring and 1099 reporting."
    - name: "mec_impact_flag"
      expr: mec_impact_flag
      comment: "Indicates whether the loan has MEC tax implications. MEC loans are treated as taxable distributions and require special reporting."
  measures:
    - name: "total_loan_count"
      expr: COUNT(1)
      comment: "Total number of policy loan records. Baseline measure of loan activity volume."
    - name: "total_original_loan_amount"
      expr: SUM(CAST(original_loan_amount AS DOUBLE))
      comment: "Total original principal amount of all loans originated. Measures the volume of policyholder borrowing activity."
    - name: "total_outstanding_principal_balance"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance across all active loans. Primary measure of policy loan exposure and a key input to lapse risk modeling."
    - name: "total_accrued_interest_balance"
      expr: SUM(CAST(accrued_interest_balance AS DOUBLE))
      comment: "Total accrued interest on outstanding policy loans. Represents interest income earned but not yet collected and contributes to total loan liability."
    - name: "total_outstanding_loan_balance"
      expr: SUM(CAST(total_outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance (principal plus accrued interest) across all loans. Represents the full policyholder loan liability and is used in CSV-to-loan ratio monitoring."
    - name: "total_repayments_to_date"
      expr: SUM(CAST(total_repayments_to_date AS DOUBLE))
      comment: "Total cumulative repayments made on all loans. Measures policyholder loan repayment behavior and reduces net outstanding exposure."
    - name: "total_collateral_csv_amount"
      expr: SUM(CAST(collateral_csv_amount AS DOUBLE))
      comment: "Total cash surrender value pledged as collateral for policy loans. Represents the security backing outstanding loan balances."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across all active policy loans. Used to monitor loan pricing adequacy and compare against crediting rates."
    - name: "avg_loan_to_csv_ratio"
      expr: AVG(CAST(to_csv_ratio AS DOUBLE))
      comment: "Average loan-to-CSV ratio across all loans. Policies with high loan-to-CSV ratios are at elevated risk of lapse; this metric is a key early warning indicator."
    - name: "apl_loan_count"
      expr: COUNT(CASE WHEN apl_trigger_flag = TRUE THEN 1 END)
      comment: "Number of loans triggered by the Automatic Premium Loan provision. APL activation indicates policyholders unable to pay premiums — a leading lapse risk signal."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_dividend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participating policy dividend metrics tracking declared amounts, cash payments, premium reductions, loan reductions, and paid-up addition values. Used by actuaries, finance, and product management to monitor dividend scale performance, option elections, and policyholder value delivery."
  source: "`life_insurance_ecm`.`policy`.`dividend`"
  dimensions:
    - name: "dividend_status"
      expr: dividend_status
      comment: "Current status of the dividend record (e.g., Declared, Paid, Reversed). Used to filter active vs. reversed dividends."
    - name: "option_code"
      expr: option_code
      comment: "Dividend option elected by the policyholder (e.g., Cash, Premium Reduction, Paid-Up Additions, Accumulate at Interest). Tracks option election distribution for product design and profitability analysis."
    - name: "declaration_date_year"
      expr: YEAR(declaration_date)
      comment: "Year of dividend declaration. Used to trend annual dividend scale performance and compare declared amounts year-over-year."
    - name: "declaration_date_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month of dividend declaration. Used for monthly dividend production monitoring."
    - name: "special_dividend_flag"
      expr: special_dividend_flag
      comment: "Indicates whether the dividend is a special (non-recurring) dividend. Special dividends are tracked separately from regular scale dividends."
    - name: "terminal_dividend_flag"
      expr: terminal_dividend_flag
      comment: "Indicates whether the dividend is a terminal dividend paid at policy termination. Terminal dividends represent a distinct liability component."
    - name: "tax_reporting_year"
      expr: tax_reporting_year
      comment: "Tax reporting year for the dividend. Used to reconcile dividend tax reporting obligations."
    - name: "scale_version"
      expr: scale_version
      comment: "Version of the dividend scale used to calculate the dividend. Enables comparison of dividend performance across scale versions."
    - name: "apportionment_method"
      expr: apportionment_method
      comment: "Method used to apportion dividends (e.g., Contribution Method, Experience Premium Method). Affects dividend equity and regulatory compliance."
  measures:
    - name: "total_declared_amount"
      expr: SUM(CAST(declared_amount AS DOUBLE))
      comment: "Total dividend amount declared across all participating policies. Primary measure of dividend scale cost and policyholder value delivery."
    - name: "total_cash_payment_amount"
      expr: SUM(CAST(cash_payment_amount AS DOUBLE))
      comment: "Total dividends paid in cash to policyholders. Represents direct cash outflow from dividend operations."
    - name: "total_premium_reduction_amount"
      expr: SUM(CAST(premium_reduction_amount AS DOUBLE))
      comment: "Total dividends applied as premium reductions. Reduces net premium revenue but improves policyholder persistency."
    - name: "total_loan_reduction_amount"
      expr: SUM(CAST(loan_reduction_amount AS DOUBLE))
      comment: "Total dividends applied to reduce outstanding policy loans. Reduces loan exposure and associated lapse risk."
    - name: "total_pua_face_amount"
      expr: SUM(CAST(pua_face_amount AS DOUBLE))
      comment: "Total face amount of Paid-Up Additions (PUAs) purchased with dividends. PUAs increase death benefit and cash value, enhancing policyholder value."
    - name: "total_pua_cash_value"
      expr: SUM(CAST(pua_cash_value AS DOUBLE))
      comment: "Total cash value of Paid-Up Additions. Represents the accumulated savings component of PUA elections."
    - name: "total_accumulated_balance"
      expr: SUM(CAST(accumulated_balance AS DOUBLE))
      comment: "Total accumulated dividend balance (dividends left on deposit with interest). Represents a liability to policyholders and is monitored for adequacy of credited interest rates."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable dividend amount. Used for tax reporting compliance and 1099 reconciliation."
    - name: "avg_declared_amount_per_policy"
      expr: AVG(CAST(declared_amount AS DOUBLE))
      comment: "Average dividend declared per policy. Used to benchmark dividend scale generosity and compare against pricing assumptions."
    - name: "avg_interest_factor"
      expr: AVG(CAST(interest_factor AS DOUBLE))
      comment: "Average interest factor used in dividend calculations. Reflects the investment return component of the dividend scale and is monitored against portfolio yield."
    - name: "avg_mortality_factor"
      expr: AVG(CAST(mortality_factor AS DOUBLE))
      comment: "Average mortality factor used in dividend calculations. Reflects actual vs. expected mortality experience and is a key input to dividend scale reviews."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_reinstatement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy reinstatement metrics tracking lapsed policy recovery activity, reinstatement success rates, back premium collections, and processing efficiency. Used by operations, actuaries, and finance to monitor lapse recovery performance and the financial impact of reinstated policies."
  source: "`life_insurance_ecm`.`policy`.`policy_reinstatement`"
  dimensions:
    - name: "reinstatement_status"
      expr: reinstatement_status
      comment: "Current status of the reinstatement request (e.g., Approved, Denied, Pending). Primary dimension for reinstatement funnel analysis."
    - name: "reinstatement_type"
      expr: reinstatement_type
      comment: "Type of reinstatement (e.g., Standard, Simplified, Full Underwriting). Affects processing complexity and approval rates."
    - name: "application_channel"
      expr: application_channel
      comment: "Channel through which the reinstatement application was submitted (e.g., Agent, Direct, Online). Used to analyze channel effectiveness in lapse recovery."
    - name: "lapse_reason_code"
      expr: lapse_reason_code
      comment: "Reason code for the original policy lapse. Identifies root causes of lapse to inform retention strategy."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for reinstatement denial. Used to identify systemic denial patterns and improve reinstatement eligibility criteria."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for back premium collection. Used for operational monitoring of reinstatement payment processing."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the reinstatement became effective. Used to trend reinstatement activity and measure lapse recovery rates over time."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the reinstatement application was Not In Good Order (NIGO). High NIGO rates indicate process quality issues."
    - name: "evidence_of_insurability_required_flag"
      expr: evidence_of_insurability_required_flag
      comment: "Indicates whether evidence of insurability was required for reinstatement. Affects approval rates and processing timelines."
  measures:
    - name: "total_reinstatement_requests"
      expr: COUNT(1)
      comment: "Total number of reinstatement requests submitted. Baseline measure of lapse recovery activity volume."
    - name: "approved_reinstatement_count"
      expr: COUNT(CASE WHEN reinstatement_status = 'Approved' THEN 1 END)
      comment: "Number of reinstatement requests approved. Used to calculate reinstatement approval rates and measure lapse recovery effectiveness."
    - name: "denied_reinstatement_count"
      expr: COUNT(CASE WHEN reinstatement_status = 'Denied' THEN 1 END)
      comment: "Number of reinstatement requests denied. High denial counts indicate underwriting barriers to lapse recovery."
    - name: "total_back_premium_amount"
      expr: SUM(CAST(back_premium_amount AS DOUBLE))
      comment: "Total back premium collected on reinstated policies. Represents the premium recovery from lapsed policies and is a key measure of reinstatement financial impact."
    - name: "total_back_premium_interest_amount"
      expr: SUM(CAST(back_premium_interest_amount AS DOUBLE))
      comment: "Total interest charged on back premiums at reinstatement. Represents additional revenue collected as part of the reinstatement process."
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total amount collected at reinstatement (back premium, interest, and fees). Measures total cash inflow from reinstatement activity."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total reinstatement fees collected. Represents fee revenue from the reinstatement process."
    - name: "nigo_reinstatement_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN 1 END)
      comment: "Number of reinstatement applications flagged as Not In Good Order. NIGO rate is a key operational quality metric for the reinstatement process."
    - name: "avg_back_premium_per_reinstatement"
      expr: AVG(CAST(back_premium_amount AS DOUBLE))
      comment: "Average back premium amount per reinstatement request. Indicates the average financial commitment required from policyholders to reinstate, affecting reinstatement conversion rates."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_conversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy conversion metrics tracking term-to-permanent and other product conversion activity, conversion volumes, face amounts, premium changes, and processing efficiency. Used by product management, sales, and actuaries to monitor conversion privilege utilization and the financial impact of converted policies."
  source: "`life_insurance_ecm`.`policy`.`conversion`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion transaction (e.g., Term to Whole Life, Term to UL). Segments conversion activity by product transition type."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Current status of the conversion (e.g., Pending, Completed, Rejected). Used to filter completed conversions for financial analysis."
    - name: "channel"
      expr: channel
      comment: "Distribution channel through which the conversion was processed. Used to analyze channel contribution to conversion production."
    - name: "original_product_type"
      expr: original_product_type
      comment: "Product type of the original policy being converted. Identifies the source product mix driving conversion activity."
    - name: "new_premium_mode"
      expr: new_premium_mode
      comment: "Premium payment mode elected for the new converted policy. Used to analyze premium mode distribution on converted business."
    - name: "new_underwriting_class"
      expr: new_underwriting_class
      comment: "Underwriting class assigned to the new converted policy. Used to assess risk selection on converted business."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the conversion became effective. Primary time dimension for conversion production trending."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the conversion became effective. Used for annual conversion production analysis."
    - name: "nigo_flag"
      expr: nigo_flag
      comment: "Indicates whether the conversion application was Not In Good Order. NIGO rate is a key quality metric for conversion processing."
    - name: "evidence_of_insurability_required_flag"
      expr: evidence_of_insurability_required_flag
      comment: "Indicates whether evidence of insurability was required for the conversion. Affects conversion approval rates and processing timelines."
  measures:
    - name: "total_conversion_count"
      expr: COUNT(1)
      comment: "Total number of conversion transactions. Baseline measure of conversion privilege utilization volume."
    - name: "completed_conversion_count"
      expr: COUNT(CASE WHEN conversion_status = 'Completed' THEN 1 END)
      comment: "Number of successfully completed conversions. Used to calculate conversion completion rates and measure conversion privilege effectiveness."
    - name: "total_new_face_amount"
      expr: SUM(CAST(new_face_amount AS DOUBLE))
      comment: "Total face amount of newly converted policies. Measures the volume of permanent insurance production generated through conversions."
    - name: "total_original_face_amount"
      expr: SUM(CAST(original_face_amount AS DOUBLE))
      comment: "Total face amount of original policies converted. Used to calculate face amount retention rates through conversion."
    - name: "total_new_modal_premium"
      expr: SUM(CAST(new_modal_premium AS DOUBLE))
      comment: "Total modal premium on newly converted policies. Measures the premium revenue generated through conversion activity."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total conversion credits applied to new policies. Conversion credits reduce the cost of conversion for policyholders and are a key product feature metric."
    - name: "avg_new_face_amount_per_conversion"
      expr: AVG(CAST(new_face_amount AS DOUBLE))
      comment: "Average face amount of newly converted policies. Indicates the average size of permanent insurance produced through conversions."
    - name: "nigo_conversion_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN 1 END)
      comment: "Number of conversion applications flagged as Not In Good Order. High NIGO rates indicate process quality issues in conversion handling."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy service request metrics tracking policyholder and agent service activity, request volumes, SLA compliance, and financial impacts of service transactions. Used by operations management to monitor service quality, throughput, and SLA adherence."
  source: "`life_insurance_ecm`.`policy`.`service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (e.g., Beneficiary Change, Address Change, Loan Request, Surrender). Primary dimension for service request volume analysis by category."
    - name: "request_status"
      expr: request_status
      comment: "Current processing status of the service request (e.g., Pending, Completed, Cancelled). Used to monitor in-flight vs. completed requests."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the service request was submitted (e.g., Agent, Online, Phone, Mail). Used to analyze channel mix and digital adoption."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the service request was submitted. Primary time dimension for service volume trending."
    - name: "request_date_year"
      expr: YEAR(request_date)
      comment: "Year the service request was submitted. Used for annual service volume analysis."
    - name: "exchange_1035_type"
      expr: exchange_1035_type
      comment: "Type of 1035 exchange associated with the service request. Used to track tax-free exchange activity and associated financial flows."
    - name: "nigo_reason_code"
      expr: nigo_reason_code
      comment: "Reason code for Not In Good Order classification. Used to identify systemic NIGO causes and drive process improvement."
  measures:
    - name: "total_service_request_count"
      expr: COUNT(1)
      comment: "Total number of service requests submitted. Baseline measure of service operations workload volume."
    - name: "completed_service_request_count"
      expr: COUNT(CASE WHEN request_status = 'Completed' THEN 1 END)
      comment: "Number of service requests successfully completed. Used to calculate completion rates and measure operational throughput."
    - name: "sla_breached_count"
      expr: COUNT(CASE WHEN request_status != 'Completed' AND sla_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of service requests that have breached their SLA due date without completion. SLA breach rate is a primary operational quality KPI."
    - name: "total_exchange_amount_transferred"
      expr: SUM(CAST(exchange_amount_transferred AS DOUBLE))
      comment: "Total amount transferred in 1035 exchange transactions. Measures the volume of tax-free exchange business processed."
    - name: "total_reinstatement_premium_amount"
      expr: SUM(CAST(reinstatement_premium_amount AS DOUBLE))
      comment: "Total reinstatement premium amounts processed through service requests. Measures premium recovery from lapsed policies via the service channel."
    - name: "total_gain_deferred"
      expr: SUM(CAST(gain_deferred AS DOUBLE))
      comment: "Total gain deferred through 1035 exchanges. Deferred gain represents tax liability transferred to the new policy and is monitored for tax compliance."
    - name: "total_cost_basis_transferred"
      expr: SUM(CAST(cost_basis_transferred AS DOUBLE))
      comment: "Total cost basis transferred in 1035 exchanges. Used to reconcile tax basis continuity across exchange transactions."
    - name: "avg_days_to_complete"
      expr: AVG(CAST(DATEDIFF(completion_date, request_date) AS DOUBLE))
      comment: "Average number of days from service request submission to completion. Key operational efficiency metric for service center performance management."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_tax_compliance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IRC 7702 and MEC tax compliance test metrics tracking test results, compliance rates, seven-pay premium limits, and material change events across the policy portfolio. Used by compliance, actuaries, and legal to monitor tax qualification status and identify policies requiring corrective action."
  source: "`life_insurance_ecm`.`policy`.`tax_compliance_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of tax compliance test performed (e.g., Seven-Pay Test, GPT, CVAT, Corridor Test). Primary dimension for compliance test analysis."
    - name: "test_status"
      expr: test_status
      comment: "Result status of the compliance test (e.g., Pass, Fail, Pending). Used to identify non-compliant policies requiring remediation."
    - name: "mec_status"
      expr: mec_status
      comment: "MEC classification status resulting from the test (e.g., MEC, Non-MEC). Drives tax reporting and policyholder notification obligations."
    - name: "definition_election"
      expr: definition_election
      comment: "IRC 7702 definition election (GPT or CVAT) under which the test was performed. Affects test methodology and compliance thresholds."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the compliance test was performed. Used to trend compliance test activity and identify periods of elevated non-compliance."
    - name: "test_date_year"
      expr: YEAR(test_date)
      comment: "Year the compliance test was performed. Used for annual compliance monitoring and regulatory reporting."
    - name: "material_change_event_type"
      expr: material_change_event_type
      comment: "Type of material change event that triggered the compliance test (e.g., Premium Payment, Face Amount Increase). Used to identify the most common triggers of compliance testing."
    - name: "irs_reporting_flag"
      expr: irs_reporting_flag
      comment: "Indicates whether the test result requires IRS reporting. Used to ensure all reportable events are captured for regulatory filing."
    - name: "corridor_test_result"
      expr: corridor_test_result
      comment: "Result of the IRC 7702 corridor test (Pass/Fail). Corridor test failures require immediate corrective action to maintain life insurance tax status."
  measures:
    - name: "total_tests_performed"
      expr: COUNT(1)
      comment: "Total number of tax compliance tests performed. Baseline measure of compliance testing activity volume."
    - name: "failed_test_count"
      expr: COUNT(CASE WHEN test_status = 'Fail' THEN 1 END)
      comment: "Number of compliance tests that resulted in failure. Failed tests indicate policies at risk of losing life insurance tax qualification — a critical compliance KPI."
    - name: "mec_classification_count"
      expr: COUNT(CASE WHEN mec_status = 'MEC' THEN 1 END)
      comment: "Number of policies classified as MECs through compliance testing. MEC classification triggers adverse tax treatment for policyholders and requires immediate notification."
    - name: "irs_reportable_event_count"
      expr: COUNT(CASE WHEN irs_reporting_flag = TRUE THEN 1 END)
      comment: "Number of compliance test events requiring IRS reporting. Used to ensure complete and timely regulatory filing."
    - name: "total_cumulative_premiums_paid"
      expr: SUM(CAST(cumulative_premiums_paid AS DOUBLE))
      comment: "Total cumulative premiums paid across all tested policies. Used to assess proximity to seven-pay premium limits across the portfolio."
    - name: "total_seven_pay_premium_limit"
      expr: SUM(CAST(seven_pay_premium_limit AS DOUBLE))
      comment: "Total seven-pay premium limit capacity across all tested policies. Compared against cumulative premiums paid to assess MEC risk at the portfolio level."
    - name: "total_guideline_single_premium"
      expr: SUM(CAST(guideline_single_premium AS DOUBLE))
      comment: "Total guideline single premium capacity across all GPT-tested policies. Used to monitor premium headroom under the GPT test."
    - name: "total_guideline_level_premium"
      expr: SUM(CAST(guideline_level_premium AS DOUBLE))
      comment: "Total guideline level premium capacity across all GPT-tested policies. Used to monitor ongoing premium compliance under the GPT test."
    - name: "avg_cash_value_at_test"
      expr: AVG(CAST(cash_value_at_test AS DOUBLE))
      comment: "Average cash value at the time of compliance testing. Used to benchmark cash value accumulation against compliance thresholds."
    - name: "avg_death_benefit_at_test"
      expr: AVG(CAST(death_benefit_at_test AS DOUBLE))
      comment: "Average death benefit at the time of compliance testing. Used to monitor the death benefit corridor relative to account value across the portfolio."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_rider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy rider metrics tracking rider coverage, premium charges, cash values, and benefit utilization across the in-force rider population. Used by product management, actuaries, and finance to monitor rider profitability, benefit exposure, and charge adequacy."
  source: "`life_insurance_ecm`.`policy`.`rider`"
  dimensions:
    - name: "rider_status"
      expr: rider_status
      comment: "Current status of the rider (e.g., Active, Terminated, Waived). Used to filter active rider exposure."
    - name: "benefit_trigger_condition"
      expr: benefit_trigger_condition
      comment: "Condition that triggers the rider benefit (e.g., Disability, Critical Illness, Long-Term Care). Segments rider exposure by benefit type."
    - name: "premium_mode"
      expr: premium_mode
      comment: "Premium payment mode for the rider. Used to analyze rider premium collection patterns."
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State in which the rider was issued. Used for geographic distribution and state-specific regulatory compliance analysis."
    - name: "reinsurance_ceded_flag"
      expr: reinsurance_ceded_flag
      comment: "Indicates whether the rider has been ceded to a reinsurer. Used to segment net vs. gross rider exposure."
    - name: "tax_qualified_flag"
      expr: tax_qualified_flag
      comment: "Indicates whether the rider is tax-qualified. Affects tax reporting and product compliance."
    - name: "waiver_of_premium_flag"
      expr: waiver_of_premium_flag
      comment: "Indicates whether the waiver of premium benefit is active on the rider. Waiver activation represents a direct cost to the company."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the rider became effective. Used for vintage analysis of the rider block."
    - name: "guaranteed_insurability_flag"
      expr: guaranteed_insurability_flag
      comment: "Indicates whether the rider includes a guaranteed insurability option. Used to monitor future coverage obligation exposure."
  measures:
    - name: "total_rider_count"
      expr: COUNT(1)
      comment: "Total number of in-force rider records. Baseline measure of rider portfolio size."
    - name: "total_rider_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount across all in-force riders. Measures the aggregate benefit exposure from rider coverage."
    - name: "total_rider_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium charged for all in-force riders. Measures rider premium revenue and is used to assess rider charge adequacy."
    - name: "total_rider_cash_value"
      expr: SUM(CAST(cash_value AS DOUBLE))
      comment: "Total cash value accumulated in riders. Represents the policyholder savings component of cash-value riders."
    - name: "total_coi_rate_amount"
      expr: SUM(CAST(cost_of_insurance_rate AS DOUBLE))
      comment: "Total cost-of-insurance rate charges across all riders. Used to assess mortality charge adequacy on rider coverage."
    - name: "total_surrender_charge"
      expr: SUM(CAST(surrender_charge AS DOUBLE))
      comment: "Total surrender charges applicable to riders. Represents contingent revenue from early rider terminations."
    - name: "waiver_active_rider_count"
      expr: COUNT(CASE WHEN waiver_of_premium_flag = TRUE THEN 1 END)
      comment: "Number of riders with active waiver of premium benefit. Waiver activation represents a direct cost and is monitored against pricing assumptions."
    - name: "avg_rider_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium per rider. Used to benchmark rider pricing and compare against product design assumptions."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_fund_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Variable and indexed product fund allocation metrics tracking policyholder investment elections, allocation amounts, participation rates, cap and floor rates, and rebalancing activity. Used by product management, investment, and actuaries to monitor separate account fund utilization and policyholder investment behavior."
  source: "`life_insurance_ecm`.`policy`.`fund_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of fund allocation (e.g., Fixed, Variable, Indexed). Primary dimension for segmenting allocation activity by product type."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the fund allocation (e.g., Active, Terminated). Used to filter active allocations for AUM analysis."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of the investment fund (e.g., Equity, Fixed Income, Balanced, Money Market). Used to analyze policyholder asset allocation mix."
    - name: "fund_risk_rating"
      expr: fund_risk_rating
      comment: "Risk rating of the fund. Used to monitor the aggregate risk profile of policyholder investment elections."
    - name: "rebalancing_frequency"
      expr: rebalancing_frequency
      comment: "Frequency of automatic portfolio rebalancing (e.g., Quarterly, Annual). Used to analyze rebalancing feature utilization."
    - name: "dollar_cost_averaging_flag"
      expr: dollar_cost_averaging_flag
      comment: "Indicates whether dollar cost averaging is active for this allocation. Used to monitor DCA feature utilization."
    - name: "allocation_effective_date_month"
      expr: DATE_TRUNC('MONTH', allocation_effective_date)
      comment: "Month the allocation became effective. Used to trend new allocation activity and fund flow patterns."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation instruction (e.g., New Business, Transfer, Rebalance). Used to categorize fund flow activity."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total amount allocated across all fund allocations. Primary measure of assets under management in separate account and indexed products."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per fund. Used to analyze the typical concentration of policyholder investments in individual funds."
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average index participation rate across all indexed allocations. Participation rate is a key product competitiveness metric for IUL and FIA products."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average cap rate across all indexed allocations. Cap rates limit policyholder upside and are monitored against competitor offerings and hedging costs."
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate (downside protection) across all indexed allocations. Floor rates represent the minimum crediting guarantee and are a key product feature metric."
    - name: "avg_fund_expense_ratio"
      expr: AVG(CAST(fund_expense_ratio AS DOUBLE))
      comment: "Average fund expense ratio across all allocations. Fund expenses reduce policyholder returns and are monitored for competitiveness and regulatory compliance."
    - name: "total_mortality_and_expense_risk_charge"
      expr: SUM(CAST(mortality_and_expense_risk_charge AS DOUBLE))
      comment: "Total mortality and expense risk charges across all variable allocations. M&E charges are a primary revenue source for variable products and are monitored for adequacy."
    - name: "active_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'Active' THEN 1 END)
      comment: "Number of active fund allocations. Used to measure the breadth of policyholder investment elections across the separate account platform."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`policy_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy status transition metrics tracking lifecycle events, lapse activity, free-look cancellations, and regulatory reporting obligations. Used by operations, compliance, and actuaries to monitor policy lifecycle health, lapse rates, and regulatory event completeness."
  source: "`life_insurance_ecm`.`policy`.`status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "The new policy status after the transition (e.g., Active, Lapsed, Surrendered, Matured). Primary dimension for lifecycle event analysis."
    - name: "prior_status"
      expr: prior_status
      comment: "The prior policy status before the transition. Used with new_status to analyze specific transition flows (e.g., Active to Lapsed)."
    - name: "transition_reason_code"
      expr: transition_reason_code
      comment: "Reason code for the status transition. Identifies the business trigger for each lifecycle event."
    - name: "source_transaction_type"
      expr: source_transaction_type
      comment: "Type of source transaction that triggered the status change. Used to link status transitions to originating business events."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the status transition became effective. Primary time dimension for lapse rate and lifecycle event trending."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the status transition became effective. Used for annual lapse experience and lifecycle analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates whether the status transition requires regulatory reporting. Used to ensure all reportable events are captured."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the status transition was subsequently reversed. Used to identify and exclude reversed transactions from experience studies."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total number of policy status transitions. Baseline measure of lifecycle event volume."
    - name: "lapse_event_count"
      expr: COUNT(CASE WHEN new_status = 'Lapsed' THEN 1 END)
      comment: "Number of policies that transitioned to Lapsed status. Primary measure of lapse experience and a key input to persistency analysis."
    - name: "free_look_cancellation_count"
      expr: COUNT(CASE WHEN free_look_cancellation_request_date IS NOT NULL THEN 1 END)
      comment: "Number of policies cancelled during the free-look period. Free-look cancellation rate is a product quality and sales suitability indicator."
    - name: "total_free_look_refund_amount"
      expr: SUM(CAST(free_look_refund_amount AS DOUBLE))
      comment: "Total refund amounts paid on free-look cancellations. Measures the financial cost of free-look cancellations and is used to assess new business quality."
    - name: "total_overdue_premium_amount"
      expr: SUM(CAST(overdue_premium_amount AS DOUBLE))
      comment: "Total overdue premium amounts at the time of status transitions. Elevated overdue premiums are a leading indicator of lapse risk."
    - name: "regulatory_reportable_event_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of status transitions requiring regulatory reporting. Used to ensure complete and timely regulatory filing compliance."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of status transitions that were reversed. High reversal rates indicate data quality or processing issues in the policy administration system."
$$;