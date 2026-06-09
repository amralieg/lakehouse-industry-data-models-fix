-- Metric views for domain: finance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_gaap_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GAAP reserve adequacy and composition metrics for life insurance policies. Tracks net reserve levels, market risk benefit fair values, premium deficiency exposures, and LDTI transition impacts — core KPIs for CFO, Chief Actuary, and external audit sign-off."
  source: "`life_insurance_ecm`.`finance`.`gaap_reserve`"
  dimensions:
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line driving the reserve (e.g., term life, whole life, annuity) — primary segmentation for reserve analysis."
    - name: "reserve_category"
      expr: reserve_category
      comment: "Category of reserve (e.g., net premium reserve, gross premium reserve) — used to slice reserve adequacy by type."
    - name: "reserve_calculation_method"
      expr: reserve_calculation_method
      comment: "Actuarial method used (e.g., CRVM, NPR, PBR) — critical for regulatory and audit segmentation."
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve record (e.g., active, pending review) — used to filter to approved reserves."
    - name: "discount_rate_type"
      expr: discount_rate_type
      comment: "Type of discount rate applied (e.g., locked-in, current) — key LDTI dimension for interest rate sensitivity analysis."
    - name: "ldti_cohort_year"
      expr: ldti_cohort_year
      comment: "LDTI cohort year grouping — required for ASC 944 long-duration targeted improvements cohort-level reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reserve — used for multi-currency consolidation analysis."
  measures:
    - name: "total_net_reserve_amount"
      expr: SUM(CAST(net_reserve_amount AS DOUBLE))
      comment: "Total net GAAP reserve across all policies. Primary balance sheet liability metric reviewed by CFO and external auditors each quarter."
    - name: "total_gross_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total gross GAAP reserve before reinsurance offsets. Used to assess full liability exposure prior to cession."
    - name: "total_mrb_fair_value"
      expr: SUM(CAST(mrb_fair_value_amount AS DOUBLE))
      comment: "Total fair value of market risk benefits (MRBs) under ASC 944 LDTI. Directly impacts P&L volatility and is a key executive KPI for variable annuity and GMDB products."
    - name: "total_premium_deficiency_reserve"
      expr: SUM(CAST(premium_deficiency_reserve_amount AS DOUBLE))
      comment: "Total premium deficiency reserve — signals products where expected future losses exceed unearned premiums. A non-zero balance triggers immediate management intervention."
    - name: "total_ldti_transition_adjustment"
      expr: SUM(CAST(ldti_transition_adjustment_amount AS DOUBLE))
      comment: "Cumulative LDTI transition adjustment to retained earnings. Tracks the one-time balance sheet impact of ASC 944 adoption — critical for investor and regulatory communication."
    - name: "total_assumption_change_effect"
      expr: SUM(CAST(assumption_change_effect_amount AS DOUBLE))
      comment: "Total reserve impact from actuarial assumption updates in the period. Measures the sensitivity of reserves to assumption changes — a key driver of earnings volatility."
    - name: "total_actual_experience_effect"
      expr: SUM(CAST(actual_experience_effect_amount AS DOUBLE))
      comment: "Total reserve impact from actual vs. expected experience variance. Quantifies how actual policyholder behavior deviates from pricing assumptions."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate_percentage AS DOUBLE))
      comment: "Average discount rate applied across reserve cohorts. Monitors interest rate assumption levels used in reserve calculations — a key sensitivity for CFO and ALM teams."
    - name: "total_dac_asset_amount"
      expr: SUM(CAST(dac_asset_amount AS DOUBLE))
      comment: "Total DAC asset netted within GAAP reserve records. Provides a cross-check against the standalone DAC asset balance for reconciliation purposes."
    - name: "total_mrb_credit_risk_adjustment"
      expr: SUM(CAST(mrb_instrument_credit_risk_adjustment AS DOUBLE))
      comment: "Total instrument-specific credit risk adjustment on MRBs recognized in OCI. Required disclosure under ASC 944 and monitored by the Chief Actuary."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_statutory_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statutory (SAP) reserve metrics for NAIC regulatory reporting, RBC contribution analysis, and state-of-domicile compliance. Used by the appointed actuary, CFO, and regulatory affairs teams."
  source: "`life_insurance_ecm`.`finance`.`statutory_reserve`"
  dimensions:
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the statutory reserve — primary segmentation for regulatory exhibits."
    - name: "reserve_category"
      expr: reserve_category
      comment: "Category of statutory reserve (e.g., life, annuity, A&H) — maps to NAIC Annual Statement exhibit lines."
    - name: "reserve_basis_code"
      expr: reserve_basis_code
      comment: "Valuation basis code (e.g., CRVM, CARVM, PBR) — determines the regulatory methodology applied."
    - name: "reserve_status"
      expr: reserve_status
      comment: "Status of the reserve record — used to isolate finalized, actuarially signed-off reserves."
    - name: "state_of_domicile_code"
      expr: state_of_domicile_code
      comment: "State of domicile for the filing entity — required for state-specific regulatory reserve analysis."
    - name: "reserve_change_reason_code"
      expr: reserve_change_reason_code
      comment: "Reason code for reserve change — used to attribute period-over-period reserve movements to specific drivers."
  measures:
    - name: "total_statutory_reserve"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross statutory reserve. Primary regulatory liability metric filed with state insurance departments and used in RBC ratio calculations."
    - name: "total_net_statutory_reserve"
      expr: SUM(CAST(net_statutory_reserve_amount AS DOUBLE))
      comment: "Net statutory reserve after reinsurance ceded. The net liability position reported on the NAIC Annual Statement balance sheet."
    - name: "total_pbr_reserve"
      expr: SUM(CAST(pbr_reserve_amount AS DOUBLE))
      comment: "Total Principle-Based Reserve (PBR) amount. Tracks the modern risk-based reserve methodology replacing formulaic reserves — a key metric for actuarial and regulatory teams."
    - name: "total_carvm_reserve"
      expr: SUM(CAST(carvm_reserve_amount AS DOUBLE))
      comment: "Total Commissioners Annuity Reserve Valuation Method reserve. Required for annuity product regulatory reporting."
    - name: "total_crvm_reserve"
      expr: SUM(CAST(crvm_reserve_amount AS DOUBLE))
      comment: "Total Commissioners Reserve Valuation Method reserve. Standard life insurance statutory reserve basis."
    - name: "total_deficiency_reserve"
      expr: SUM(CAST(deficiency_reserve_amount AS DOUBLE))
      comment: "Total deficiency reserve — required when net premium exceeds gross premium. A non-zero balance signals pricing inadequacy and triggers regulatory scrutiny."
    - name: "total_reinsurance_ceded_reserve"
      expr: SUM(CAST(reinsurance_ceded_reserve_amount AS DOUBLE))
      comment: "Total reserve ceded to reinsurers. Measures the risk transfer benefit from reinsurance arrangements — key for capital management decisions."
    - name: "total_rbc_contribution"
      expr: SUM(CAST(rbc_contribution_amount AS DOUBLE))
      comment: "Total RBC contribution from statutory reserves. Directly feeds into the RBC ratio calculation — a primary solvency metric for regulators and rating agencies."
    - name: "total_reserve_change"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Net change in statutory reserves for the period. A key income statement driver (increase in reserves = expense) monitored in every earnings review."
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk (face amount minus reserve) across the in-force block. Measures the insurer's mortality/longevity exposure net of reserves — critical for reinsurance and capital planning."
    - name: "avg_valuation_interest_rate"
      expr: AVG(CAST(valuation_interest_rate AS DOUBLE))
      comment: "Average valuation interest rate across statutory reserve records. Monitors the interest rate assumption embedded in reserves — a key sensitivity for ALM and regulatory stress testing."
    - name: "total_tax_reserve"
      expr: SUM(CAST(tax_reserve_amount AS DOUBLE))
      comment: "Total tax reserve (IRC 807 reserve). Drives the deferred tax calculation and is a key input to the tax provision — monitored by tax and finance teams."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_dac_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred Acquisition Cost (DAC) asset metrics tracking capitalized acquisition costs, amortization progress, impairment, and VOBA components. Core KPIs for CFO, Chief Actuary, and external auditors under ASC 944 LDTI and IFRS 17."
  source: "`life_insurance_ecm`.`finance`.`dac_asset`"
  dimensions:
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the DAC asset — primary segmentation for acquisition cost analysis."
    - name: "amortization_method"
      expr: amortization_method
      comment: "DAC amortization method (e.g., straight-line, benefit ratio) — determines the pattern of expense recognition."
    - name: "dac_asset_status"
      expr: dac_asset_status
      comment: "Current status of the DAC asset record (e.g., active, fully amortized, impaired) — used to isolate active balances."
    - name: "issue_year"
      expr: issue_year
      comment: "Policy issue year cohort — enables vintage analysis of DAC balances and amortization rates."
    - name: "gaap_reporting_basis"
      expr: gaap_reporting_basis
      comment: "GAAP reporting basis (e.g., US GAAP, IFRS 17) — used to segment DAC metrics by accounting standard."
    - name: "ldti_cohort_grouping_key"
      expr: ldti_cohort_grouping_key
      comment: "LDTI cohort grouping key — required for ASC 944 cohort-level DAC amortization tracking."
  measures:
    - name: "total_unamortized_dac_balance"
      expr: SUM(CAST(unamortized_dac_balance AS DOUBLE))
      comment: "Total unamortized DAC balance on the balance sheet. Primary DAC asset metric reviewed by CFO and auditors — represents future expense to be recognized."
    - name: "total_dac_capitalized"
      expr: SUM(CAST(dac_capitalized_amount AS DOUBLE))
      comment: "Total acquisition costs capitalized in the period. Measures the volume of new business acquisition spending deferred to future periods."
    - name: "total_actual_amortization"
      expr: SUM(CAST(actual_amortization_amount AS DOUBLE))
      comment: "Total DAC amortization expense recognized in the period. A key P&L line item directly impacting reported earnings."
    - name: "total_scheduled_amortization"
      expr: SUM(CAST(scheduled_amortization_amount AS DOUBLE))
      comment: "Total scheduled DAC amortization per the amortization plan. Used to compare actual vs. planned amortization and identify deviations."
    - name: "total_cumulative_amortization"
      expr: SUM(CAST(cumulative_amortization_balance AS DOUBLE))
      comment: "Total cumulative DAC amortization to date. Provides a lifecycle view of how much of the original capitalized cost has been expensed."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total DAC impairment losses recognized. A non-zero balance signals that future profits are insufficient to recover capitalized costs — triggers immediate management review."
    - name: "total_voba_component"
      expr: SUM(CAST(voba_component_amount AS DOUBLE))
      comment: "Total Value of Business Acquired (VOBA) component within DAC. Tracks the intangible asset from acquired blocks of business — key for M&A integration reporting."
    - name: "total_voba_amortization"
      expr: SUM(CAST(voba_amortization_amount AS DOUBLE))
      comment: "Total VOBA amortization expense in the period. Monitors the run-off of acquired business intangibles — relevant for post-acquisition performance tracking."
    - name: "total_shadow_dac_adjustment"
      expr: SUM(CAST(shadow_dac_adjustment AS DOUBLE))
      comment: "Total shadow DAC adjustment (unrealized gain/loss impact on DAC). Required for GAAP reporting of investment-linked DAC adjustments — monitored by the CFO and investment teams."
    - name: "total_ifrs17_acquisition_cash_flow_asset"
      expr: SUM(CAST(ifrs17_acquisition_cash_flow_asset AS DOUBLE))
      comment: "Total IFRS 17 acquisition cash flow asset. Tracks the IFRS 17 equivalent of DAC for entities reporting under international standards."
    - name: "total_variance_from_prior_period"
      expr: SUM(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Total period-over-period variance in DAC balance. Quantifies the net change in DAC driven by new business, amortization, and adjustments — a key earnings driver."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_dac_amortization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period-level DAC amortization transaction metrics for detailed expense tracking, variance analysis, and multi-GAAP reconciliation (US GAAP, IFRS 17, SAP). Used by finance, actuarial, and external audit teams."
  source: "`life_insurance_ecm`.`finance`.`dac_amortization`"
  dimensions:
    - name: "product_line"
      expr: product_line
      comment: "Product line for the amortization transaction — primary segmentation for DAC expense analysis."
    - name: "amortization_method"
      expr: amortization_method
      comment: "Amortization method applied (e.g., straight-line, benefit ratio) — used to compare expense patterns across methods."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the amortization transaction — enables period-over-period trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the amortization — used for annual reporting and budget vs. actual comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the amortization — used for quarterly earnings reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the amortization entry — used to filter to approved, posted transactions for financial reporting."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for amortization adjustments — used to categorize and investigate out-of-pattern amortization."
  measures:
    - name: "total_actual_amortization"
      expr: SUM(CAST(actual_amortization_amount AS DOUBLE))
      comment: "Total actual DAC amortization expense for the period. Primary P&L metric for DAC expense — reviewed in every earnings close."
    - name: "total_gaap_amortization"
      expr: SUM(CAST(gaap_amortization_amount AS DOUBLE))
      comment: "Total US GAAP DAC amortization. Used for GAAP financial statement preparation and external reporting."
    - name: "total_ifrs17_amortization"
      expr: SUM(CAST(ifrs17_amortization_amount AS DOUBLE))
      comment: "Total IFRS 17 DAC amortization. Used for international financial reporting and multi-GAAP reconciliation."
    - name: "total_sap_amortization"
      expr: SUM(CAST(sap_amortization_amount AS DOUBLE))
      comment: "Total statutory (SAP) DAC amortization. Used for NAIC Annual Statement preparation and regulatory reporting."
    - name: "total_scheduled_amortization"
      expr: SUM(CAST(scheduled_amortization_amount AS DOUBLE))
      comment: "Total scheduled DAC amortization per the amortization plan. Baseline for variance analysis against actual amortization."
    - name: "total_variance_from_prior_period"
      expr: SUM(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Total variance in amortization from the prior period. Quantifies period-over-period DAC expense changes — a key earnings quality metric."
    - name: "total_interest_accretion"
      expr: SUM(CAST(interest_accretion_amount AS DOUBLE))
      comment: "Total interest accretion on DAC balances. Represents the time-value-of-money component of DAC amortization under interest-accretion methods."
    - name: "total_shadow_dac_adjustment"
      expr: SUM(CAST(shadow_dac_adjustment AS DOUBLE))
      comment: "Total shadow DAC adjustment in the period. Tracks the OCI-driven DAC adjustment from unrealized investment gains/losses — monitored by CFO and investment teams."
    - name: "total_remaining_dac_balance"
      expr: SUM(CAST(remaining_dac_balance AS DOUBLE))
      comment: "Total remaining unamortized DAC balance after current period amortization. Forward-looking balance sheet metric for future expense recognition."
    - name: "total_cumulative_amortization_balance"
      expr: SUM(CAST(cumulative_amortization_balance AS DOUBLE))
      comment: "Total cumulative amortization balance to date. Lifecycle metric showing total DAC expense recognized since policy inception."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_ifrs17_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 17 insurance contract measurement metrics including CSM movement, FCF estimates, risk adjustment, insurance revenue, and service expense. Core KPIs for CFO, Chief Actuary, and investor relations under IFRS 17."
  source: "`life_insurance_ecm`.`finance`.`ifrs17_measurement`"
  dimensions:
    - name: "measurement_model"
      expr: measurement_model
      comment: "IFRS 17 measurement model applied (GMM, PAA, VFA) — primary segmentation for IFRS 17 financial analysis."
    - name: "cohort_year"
      expr: cohort_year
      comment: "Contract cohort year — required for IFRS 17 cohort-level CSM and FCF tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the measurement — used for multi-currency IFRS 17 reporting."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement record (e.g., approved, pending) — used to isolate finalized measurements for reporting."
  measures:
    - name: "total_insurance_revenue"
      expr: SUM(CAST(insurance_revenue AS DOUBLE))
      comment: "Total IFRS 17 insurance revenue recognized in the period. Top-line revenue metric for IFRS 17 reporters — directly impacts reported profitability."
    - name: "total_insurance_service_expense"
      expr: SUM(CAST(insurance_service_expense AS DOUBLE))
      comment: "Total insurance service expense (incurred claims + loss component + acquisition expense amortization). Primary cost metric under IFRS 17 — drives the insurance service result."
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims AS DOUBLE))
      comment: "Total incurred claims within insurance service expense. Core loss metric monitored by CFO and Chief Actuary for profitability assessment."
    - name: "total_closing_csm"
      expr: SUM(CAST(closing_csm AS DOUBLE))
      comment: "Total closing Contractual Service Margin (CSM) balance. Represents unearned profit locked in insurance contracts — a key balance sheet metric for IFRS 17 reporters."
    - name: "total_csm_release_for_service"
      expr: SUM(CAST(csm_release_for_service AS DOUBLE))
      comment: "Total CSM released to P&L for services provided. Directly drives IFRS 17 insurance revenue — monitored each reporting period."
    - name: "total_csm_interest_accretion"
      expr: SUM(CAST(csm_interest_accretion AS DOUBLE))
      comment: "Total interest accretion on the CSM balance. Represents the unwinding of the time value of money on deferred profit — a key IFRS 17 P&L component."
    - name: "total_closing_fcf_estimate"
      expr: SUM(CAST(closing_fcf_estimate AS DOUBLE))
      comment: "Total closing Fulfilment Cash Flow (FCF) estimate. Represents the present value of future cash flows — the primary liability measurement under IFRS 17."
    - name: "total_closing_risk_adjustment"
      expr: SUM(CAST(closing_risk_adjustment AS DOUBLE))
      comment: "Total closing risk adjustment for non-financial risk. Measures the compensation required for bearing uncertainty in cash flows — a required IFRS 17 disclosure."
    - name: "total_risk_adjustment_release"
      expr: SUM(CAST(risk_adjustment_release AS DOUBLE))
      comment: "Total risk adjustment released to P&L in the period. Contributes to insurance revenue and reflects reduction in uncertainty over time."
    - name: "total_onerous_contract_loss"
      expr: SUM(CAST(onerous_contract_loss AS DOUBLE))
      comment: "Total loss recognized on onerous contracts. A non-zero balance signals contracts where expected losses exceed expected profits — triggers immediate management review."
    - name: "total_insurance_finance_expense"
      expr: SUM(CAST(insurance_finance_expense AS DOUBLE))
      comment: "Total insurance finance expense (interest on insurance liabilities). Represents the cost of carrying insurance liabilities over time — a key IFRS 17 P&L line."
    - name: "total_experience_variance"
      expr: SUM(CAST(experience_variance AS DOUBLE))
      comment: "Total experience variance (actual vs. expected cash flows). Measures how actual policyholder behavior deviates from assumptions — a key driver of IFRS 17 earnings volatility."
    - name: "total_assumption_change_impact"
      expr: SUM(CAST(assumption_change_impact AS DOUBLE))
      comment: "Total impact of actuarial assumption changes on IFRS 17 measurements. Quantifies earnings sensitivity to assumption updates — monitored by CFO and Chief Actuary."
    - name: "total_acquisition_expense"
      expr: SUM(CAST(acquisition_expense AS DOUBLE))
      comment: "Total acquisition expense recognized under IFRS 17. Tracks the cost of acquiring new insurance contracts — a key efficiency metric for distribution and pricing teams."
    - name: "total_reinsurance_held_csm"
      expr: SUM(CAST(reinsurance_held_csm AS DOUBLE))
      comment: "Total CSM on reinsurance contracts held. Measures the value of reinsurance protection from an IFRS 17 perspective — key for capital and risk management decisions."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_ifrs17_contract_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 17 contract group portfolio metrics tracking CSM movement, FCF estimates, coverage units, and OCI allocation. Used by CFO, Chief Actuary, and investor relations for IFRS 17 portfolio-level reporting."
  source: "`life_insurance_ecm`.`finance`.`ifrs17_contract_group`"
  dimensions:
    - name: "measurement_model"
      expr: measurement_model
      comment: "IFRS 17 measurement model (GMM, PAA, VFA) — primary segmentation for contract group analysis."
    - name: "profitability_classification"
      expr: profitability_classification
      comment: "Profitability classification (profitable, onerous, no significant possibility of becoming onerous) — required IFRS 17 grouping criterion."
    - name: "transition_approach"
      expr: transition_approach
      comment: "IFRS 17 transition approach applied (full retrospective, modified retrospective, fair value) — used to segment transition-period impacts."
    - name: "oci_pl_allocation_election"
      expr: oci_pl_allocation_election
      comment: "OCI vs. P&L allocation election for insurance finance income/expense — drives reported earnings volatility."
    - name: "ifrs17_contract_group_status"
      expr: ifrs17_contract_group_status
      comment: "Status of the contract group (active, derecognized) — used to isolate active in-force groups."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency of the contract group — used for multi-currency IFRS 17 consolidation."
  measures:
    - name: "total_insurance_revenue_recognized"
      expr: SUM(CAST(insurance_revenue_recognized AS DOUBLE))
      comment: "Total insurance revenue recognized across contract groups. Top-line IFRS 17 revenue metric for portfolio-level performance reporting."
    - name: "total_insurance_service_expense"
      expr: SUM(CAST(insurance_service_expense AS DOUBLE))
      comment: "Total insurance service expense across contract groups. Primary cost metric for IFRS 17 insurance service result."
    - name: "total_closing_csm_balance"
      expr: SUM(CAST(closing_csm_balance AS DOUBLE))
      comment: "Total closing CSM balance across all contract groups. Represents the aggregate unearned profit in the insurance portfolio — a key balance sheet metric."
    - name: "total_csm_release_amount"
      expr: SUM(CAST(csm_release_amount AS DOUBLE))
      comment: "Total CSM released to P&L for services rendered. Directly drives IFRS 17 insurance revenue — monitored each reporting period."
    - name: "total_csm_new_business_addition"
      expr: SUM(CAST(csm_new_business_addition AS DOUBLE))
      comment: "Total CSM added from new business written. Measures the value of new contracts added to the portfolio — a key growth metric for IFRS 17 reporters."
    - name: "total_closing_fcf_estimate"
      expr: SUM(CAST(closing_fcf_estimate AS DOUBLE))
      comment: "Total closing FCF estimate across contract groups. Aggregate present value of future insurance cash flows — primary IFRS 17 liability metric."
    - name: "total_loss_component_closing"
      expr: SUM(CAST(loss_component_closing AS DOUBLE))
      comment: "Total closing loss component across onerous contract groups. Measures the aggregate loss recognized on unprofitable contracts — triggers management intervention."
    - name: "total_risk_adjustment_closing"
      expr: SUM(CAST(risk_adjustment_closing AS DOUBLE))
      comment: "Total closing risk adjustment across contract groups. Aggregate compensation for non-financial risk uncertainty — required IFRS 17 balance sheet disclosure."
    - name: "total_oci_amount"
      expr: SUM(CAST(oci_amount AS DOUBLE))
      comment: "Total OCI amount from insurance finance income/expense. Measures the portion of interest effects recognized in OCI rather than P&L — impacts comprehensive income reporting."
    - name: "total_insurance_finance_income_expense"
      expr: SUM(CAST(insurance_finance_income_expense AS DOUBLE))
      comment: "Total insurance finance income/expense recognized in P&L. Represents the interest unwinding on insurance liabilities — a key IFRS 17 P&L component."
    - name: "total_coverage_units_closing"
      expr: SUM(CAST(coverage_units_closing AS DOUBLE))
      comment: "Total closing coverage units across contract groups. Coverage units drive CSM release allocation — a key operational metric for IFRS 17 actuarial teams."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-Based Capital (RBC) metrics for NAIC regulatory solvency monitoring. Tracks RBC ratio, total adjusted capital, individual risk components (C0-C4), and regulatory action level thresholds. Used by CFO, CRO, and regulatory affairs teams."
  source: "`life_insurance_ecm`.`finance`.`rbc_calculation`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year of the RBC calculation — primary time dimension for annual regulatory filing analysis."
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter — used for quarterly RBC trend monitoring."
    - name: "calculation_type"
      expr: calculation_type
      comment: "Type of RBC calculation (annual, quarterly, interim) — used to isolate official regulatory filings."
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the RBC calculation (preliminary, final, filed) — used to filter to finalized, filed calculations."
    - name: "action_level_trigger"
      expr: action_level_trigger
      comment: "Regulatory action level triggered (none, company action, regulatory action, authorized control, mandatory control) — critical for regulatory compliance monitoring."
    - name: "regulator_jurisdiction"
      expr: regulator_jurisdiction
      comment: "Regulatory jurisdiction for the RBC filing — used for multi-state regulatory analysis."
    - name: "calculation_methodology"
      expr: calculation_methodology
      comment: "Methodology used for RBC calculation — used to track methodology changes over time."
  measures:
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio (Total Adjusted Capital / Company Action Level RBC). The primary solvency metric for life insurers — regulators require minimum 200% for no action. Monitored by CFO, CRO, and board."
    - name: "total_adjusted_capital"
      expr: SUM(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Total Adjusted Capital (TAC) across entities. Numerator of the RBC ratio — represents the insurer's available capital buffer."
    - name: "total_rbc_after_covariance"
      expr: SUM(CAST(total_rbc_after_covariance AS DOUBLE))
      comment: "Total RBC requirement after covariance adjustment. Denominator basis for the RBC ratio — the aggregate risk capital requirement."
    - name: "total_company_action_level_rbc"
      expr: SUM(CAST(company_action_level_rbc AS DOUBLE))
      comment: "Total Company Action Level RBC (200% of authorized control level). The threshold below which management must submit a corrective action plan to regulators."
    - name: "total_c1_asset_risk_fixed_income"
      expr: SUM(CAST(c1_asset_risk_fixed_income AS DOUBLE))
      comment: "Total C1 fixed income asset risk charge. Measures capital required for credit risk in the bond portfolio — a key driver of RBC for life insurers."
    - name: "total_c1_asset_risk_equity"
      expr: SUM(CAST(c1_asset_risk_equity AS DOUBLE))
      comment: "Total C1 equity asset risk charge. Measures capital required for equity market risk — relevant for variable annuity and separate account products."
    - name: "total_c2_insurance_risk"
      expr: SUM(CAST(c2_insurance_risk AS DOUBLE))
      comment: "Total C2 insurance risk charge (mortality, morbidity, longevity). Measures capital required for underwriting risk — a primary driver of RBC for life insurance products."
    - name: "total_c3_interest_rate_risk"
      expr: SUM(CAST(c3_interest_rate_risk AS DOUBLE))
      comment: "Total C3 interest rate risk charge. Measures capital required for asset-liability mismatch risk — critical for fixed annuity and whole life products."
    - name: "total_c3_market_risk"
      expr: SUM(CAST(c3_market_risk AS DOUBLE))
      comment: "Total C3 market risk charge (variable annuity guarantees). Measures capital required for market risk on variable products — a key metric for VA writers."
    - name: "total_c4_business_risk"
      expr: SUM(CAST(c4_business_risk AS DOUBLE))
      comment: "Total C4 business risk charge (operational and general business risk). Measures capital required for non-insurance operational risks."
    - name: "total_covariance_adjustment"
      expr: SUM(CAST(covariance_adjustment AS DOUBLE))
      comment: "Total covariance adjustment applied to RBC components. Reflects the diversification benefit across risk categories — reduces total RBC requirement."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry volume, financial activity, and close quality metrics. Tracks debit/credit volumes, intercompany activity, reversal rates, and multi-GAAP posting patterns. Used by Controller, CFO, and SOX compliance teams."
  source: "`life_insurance_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the journal entry — primary time dimension for close activity analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — used for annual financial reporting and audit."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (standard, adjusting, reversing, eliminating) — used to categorize close activity."
    - name: "entry_category"
      expr: entry_category
      comment: "Business category of the entry (e.g., reserve, DAC, claims, investment) — used to attribute financial activity to business processes."
    - name: "accounting_basis"
      expr: accounting_basis
      comment: "Accounting basis (GAAP, SAP, IFRS 17) — used for multi-GAAP financial analysis."
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the journal entry — used to attribute financial activity to product segments."
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the journal entry (draft, posted, reversed) — used to isolate posted entries for financial reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the journal entry — used for reconciliation and data lineage analysis."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany journal entries — used to isolate and monitor intercompany elimination activity."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries. Measures the gross volume of financial activity posted to the general ledger — a key close completeness metric."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries. Should equal total debits for a balanced ledger — used for close quality and reconciliation monitoring."
    - name: "total_functional_currency_debit"
      expr: SUM(CAST(functional_currency_debit AS DOUBLE))
      comment: "Total debit amount in functional currency. Used for consolidated financial reporting in the entity's functional currency."
    - name: "total_functional_currency_credit"
      expr: SUM(CAST(functional_currency_credit AS DOUBLE))
      comment: "Total credit amount in functional currency. Used for consolidated financial reporting and currency translation analysis."
    - name: "total_journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Measures close activity volume — used to monitor close efficiency and identify unusual posting patterns."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversal journal entries. High reversal rates may indicate close quality issues or systematic errors — monitored by the Controller and SOX teams."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries. Used to monitor intercompany elimination completeness — a key consolidation quality metric."
    - name: "ldti_entry_count"
      expr: COUNT(CASE WHEN ldti_indicator = TRUE THEN 1 END)
      comment: "Count of journal entries related to LDTI (ASC 944 long-duration targeted improvements). Tracks the volume of LDTI-specific accounting activity — used for implementation monitoring."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_reinsurance_recoverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance recoverable asset metrics tracking gross and net recoverables, credit risk exposure, collateral coverage, and aging. Used by CFO, CRO, and reinsurance management teams for counterparty risk and capital management decisions."
  source: "`life_insurance_ecm`.`finance`.`reinsurance_recoverable`"
  dimensions:
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the recoverable — primary segmentation for reinsurance recoverable analysis."
    - name: "recoverable_type"
      expr: recoverable_type
      comment: "Type of recoverable (e.g., reserve credit, paid claims, IBNR) — used to categorize reinsurance asset components."
    - name: "recoverable_status"
      expr: recoverable_status
      comment: "Status of the recoverable (e.g., billed, collected, disputed) — used to monitor collection efficiency."
    - name: "reinsurer_credit_rating"
      expr: reinsurer_credit_rating
      comment: "Credit rating of the reinsurer — primary dimension for counterparty credit risk analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for outstanding recoverables — used to identify overdue collections and credit risk concentrations."
    - name: "accounting_basis"
      expr: accounting_basis
      comment: "Accounting basis (GAAP, SAP) — used for multi-basis reinsurance recoverable reporting."
    - name: "gaap_classification"
      expr: gaap_classification
      comment: "GAAP balance sheet classification of the recoverable — used for financial statement presentation."
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral held against the recoverable (e.g., LOC, trust, funds withheld) — used for credit risk mitigation analysis."
  measures:
    - name: "total_gross_recoverable"
      expr: SUM(CAST(gross_recoverable_amount AS DOUBLE))
      comment: "Total gross reinsurance recoverable asset. Primary balance sheet metric for reinsurance credit exposure — monitored by CFO and CRO."
    - name: "total_net_recoverable"
      expr: SUM(CAST(net_recoverable_amount AS DOUBLE))
      comment: "Total net reinsurance recoverable after allowance for uncollectible amounts. The net asset value recognized on the balance sheet."
    - name: "total_allowance_for_uncollectible"
      expr: SUM(CAST(allowance_for_uncollectible AS DOUBLE))
      comment: "Total allowance for uncollectible reinsurance recoverables. Measures the credit loss reserve against reinsurer default risk — a key credit risk metric."
    - name: "total_collateral_held"
      expr: SUM(CAST(collateral_held_amount AS DOUBLE))
      comment: "Total collateral held against reinsurance recoverables. Measures the secured portion of reinsurance credit exposure — used for net credit risk calculation."
    - name: "total_ifrs17_csm_impact"
      expr: SUM(CAST(ifrs17_csm_impact AS DOUBLE))
      comment: "Total IFRS 17 CSM impact from reinsurance contracts held. Measures how reinsurance affects the CSM balance under IFRS 17 — key for IFRS 17 reinsurance accounting."
    - name: "uncollectible_rate"
      expr: ROUND(100.0 * SUM(CAST(allowance_for_uncollectible AS DOUBLE)) / NULLIF(SUM(CAST(gross_recoverable_amount AS DOUBLE)), 0), 2)
      comment: "Allowance for uncollectible as a percentage of gross recoverable. Measures the credit quality of the reinsurance recoverable portfolio — a key counterparty risk KPI monitored by CRO."
    - name: "collateral_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(collateral_held_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_recoverable_amount AS DOUBLE)), 0), 2)
      comment: "Collateral held as a percentage of gross recoverable. Measures the secured coverage of reinsurance credit exposure — used to assess counterparty risk mitigation effectiveness."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Income tax provision metrics for life insurance entities including effective tax rate, deferred tax positions, DAC and reserve temporary differences, and NOL carryforwards. Used by CFO, Tax Director, and external auditors."
  source: "`life_insurance_ecm`.`finance`.`tax_provision`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision — primary time dimension for annual tax reporting."
    - name: "provision_method"
      expr: provision_method
      comment: "Tax provision method (e.g., ASC 740 current/deferred) — used to categorize provision approaches."
    - name: "provision_status"
      expr: provision_status
      comment: "Status of the tax provision (preliminary, final, filed) — used to isolate finalized provisions for reporting."
    - name: "gaap_reporting_basis"
      expr: gaap_reporting_basis
      comment: "GAAP reporting basis for the provision — used for multi-GAAP tax analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "External audit status of the tax provision — used to monitor audit completion and open items."
  measures:
    - name: "total_tax_expense"
      expr: SUM(CAST(total_tax_expense AS DOUBLE))
      comment: "Total income tax expense (current + deferred + state + foreign). Primary tax P&L metric reviewed by CFO and Tax Director each quarter."
    - name: "total_current_tax_expense"
      expr: SUM(CAST(current_tax_expense AS DOUBLE))
      comment: "Total current period tax expense. Represents taxes payable to tax authorities in the current period — a key cash flow metric."
    - name: "total_deferred_tax_expense"
      expr: SUM(CAST(deferred_tax_expense AS DOUBLE))
      comment: "Total deferred tax expense. Represents the tax impact of temporary differences — a key non-cash P&L item monitored by CFO."
    - name: "total_pretax_income"
      expr: SUM(CAST(pretax_income AS DOUBLE))
      comment: "Total pre-tax income across entities. Denominator for effective tax rate calculation — a primary earnings metric."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across entities. Measures the actual tax burden relative to pre-tax income — a key metric for investor relations and tax planning."
    - name: "total_dta_balance"
      expr: SUM(CAST(dta_balance AS DOUBLE))
      comment: "Total deferred tax asset balance. Represents future tax benefits from temporary differences — monitored for realizability and valuation allowance adequacy."
    - name: "total_dtl_balance"
      expr: SUM(CAST(dtl_balance AS DOUBLE))
      comment: "Total deferred tax liability balance. Represents future tax obligations from temporary differences — a key balance sheet metric."
    - name: "total_net_deferred_tax_position"
      expr: SUM(CAST(net_deferred_tax_position AS DOUBLE))
      comment: "Net deferred tax position (DTA minus DTL). Measures the overall deferred tax asset or liability on the balance sheet — monitored by CFO and Tax Director."
    - name: "total_valuation_allowance"
      expr: SUM(CAST(valuation_allowance AS DOUBLE))
      comment: "Total valuation allowance against deferred tax assets. Measures the portion of DTAs deemed not realizable — a key indicator of tax asset quality and future profitability expectations."
    - name: "total_nol_carryforward"
      expr: SUM(CAST(nol_carryforward AS DOUBLE))
      comment: "Total net operating loss carryforward. Represents future tax deductions available — a key tax planning metric for entities with historical losses."
    - name: "total_dac_temporary_difference"
      expr: SUM(CAST(dac_temporary_difference AS DOUBLE))
      comment: "Total DAC-related temporary difference. Measures the tax vs. GAAP timing difference on acquisition costs — a significant deferred tax driver for life insurers."
    - name: "total_reserve_temporary_difference"
      expr: SUM(CAST(reserve_temporary_difference AS DOUBLE))
      comment: "Total reserve-related temporary difference. Measures the tax vs. GAAP timing difference on insurance reserves — the largest deferred tax driver for most life insurers."
    - name: "total_ldti_tax_impact"
      expr: SUM(CAST(ldti_tax_impact AS DOUBLE))
      comment: "Total tax impact of LDTI (ASC 944) adoption. Tracks the deferred tax effect of the LDTI transition adjustment — a one-time but material item for LDTI adopters."
    - name: "total_state_tax_expense"
      expr: SUM(CAST(state_tax_expense AS DOUBLE))
      comment: "Total state income tax expense. Monitors state tax burden across jurisdictions — used for state tax planning and apportionment analysis."
$$;