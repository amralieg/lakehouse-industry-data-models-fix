-- Metric views for domain: finance | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_gaap_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GAAP reserve adequacy, LDTI transition impact, and reserve movement analysis for life insurance liabilities under US GAAP accounting standards"
  source: "`life_insurance_ecm`.`finance`.`gaap_reserve`"
  dimensions:
    - name: "reserve_category"
      expr: reserve_category
      comment: "Type of GAAP reserve (e.g., benefit reserve, claim reserve, premium deficiency reserve)"
    - name: "reserve_status"
      expr: reserve_status
      comment: "Current status of the reserve calculation (e.g., preliminary, approved, final)"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for segmentation of reserve liabilities"
    - name: "ldti_cohort_year"
      expr: ldti_cohort_year
      comment: "LDTI cohort year for long-duration contract grouping under ASU 2018-12"
    - name: "reserve_calculation_method"
      expr: reserve_calculation_method
      comment: "Actuarial method used for reserve calculation (e.g., net premium, gross premium)"
    - name: "discount_rate_type"
      expr: discount_rate_type
      comment: "Type of discount rate applied (e.g., upper-medium grade, risk-free)"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the reserve calculation was approved"
    - name: "approval_quarter"
      expr: CONCAT('Q', QUARTER(approval_date), '-', YEAR(approval_date))
      comment: "Quarter and year of reserve approval"
    - name: "sox_control_certification_flag"
      expr: sox_control_certification_flag
      comment: "SOX control certification flag for regulatory compliance"
  measures:
    - name: "total_net_reserve_amount"
      expr: SUM(CAST(net_reserve_amount AS DOUBLE))
      comment: "Total net GAAP reserve liability after reinsurance ceded"
    - name: "total_gross_reserve_amount"
      expr: SUM(CAST(reserve_amount AS DOUBLE))
      comment: "Total gross GAAP reserve liability before reinsurance"
    - name: "total_reinsurance_recoverable"
      expr: SUM(CAST(reinsurance_recoverable_amount AS DOUBLE))
      comment: "Total reinsurance recoverable reducing gross reserves"
    - name: "total_ldti_transition_adjustment"
      expr: SUM(CAST(ldti_transition_adjustment_amount AS DOUBLE))
      comment: "Total LDTI transition adjustment impact from ASU 2018-12 adoption"
    - name: "total_premium_deficiency_reserve"
      expr: SUM(CAST(premium_deficiency_reserve_amount AS DOUBLE))
      comment: "Total premium deficiency reserve for loss recognition on unprofitable blocks"
    - name: "total_dac_asset_amount"
      expr: SUM(CAST(dac_asset_amount AS DOUBLE))
      comment: "Total deferred acquisition cost asset associated with reserves"
    - name: "total_assumption_change_effect"
      expr: SUM(CAST(assumption_change_effect_amount AS DOUBLE))
      comment: "Total impact of actuarial assumption changes on reserves"
    - name: "total_actual_experience_effect"
      expr: SUM(CAST(actual_experience_effect_amount AS DOUBLE))
      comment: "Total impact of actual vs expected experience on reserves"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate_percentage AS DOUBLE))
      comment: "Average discount rate applied to reserve cash flows"
    - name: "reserve_count"
      expr: COUNT(DISTINCT gaap_reserve_id)
      comment: "Count of distinct GAAP reserve records"
    - name: "policy_count_in_reserves"
      expr: SUM(CAST(policy_count AS DOUBLE))
      comment: "Total count of policies included in reserve calculations"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount_total AS DOUBLE))
      comment: "Total face amount of insurance coverage in force"
    - name: "gaap_statutory_difference"
      expr: SUM(CAST(gaap_vs_statutory_difference_amount AS DOUBLE))
      comment: "Total difference between GAAP and statutory reserve bases"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_statutory_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statutory reserve adequacy, PBR vs formula reserve comparison, and regulatory capital impact for state insurance department reporting"
  source: "`life_insurance_ecm`.`finance`.`statutory_reserve`"
  dimensions:
    - name: "reserve_category"
      expr: reserve_category
      comment: "Statutory reserve category (e.g., life, annuity, accident and health)"
    - name: "reserve_status"
      expr: reserve_status
      comment: "Status of statutory reserve calculation (e.g., preliminary, filed, approved)"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for statutory reserve segmentation"
    - name: "state_of_domicile_code"
      expr: state_of_domicile_code
      comment: "State insurance department jurisdiction for reserve filing"
    - name: "reserve_basis_code"
      expr: reserve_basis_code
      comment: "Statutory reserve basis code (e.g., CRVM, CARVM, PBR)"
    - name: "exhibit_line_number"
      expr: exhibit_line_number
      comment: "Annual statement exhibit line number for regulatory reporting"
    - name: "cohort_identifier"
      expr: cohort_identifier
      comment: "Cohort grouping identifier for reserve segmentation"
    - name: "cso_mortality_table_code"
      expr: cso_mortality_table_code
      comment: "Commissioner's Standard Ordinary mortality table used in reserve calculation"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Year the statutory reserve was booked"
    - name: "booking_quarter"
      expr: CONCAT('Q', QUARTER(booking_date), '-', YEAR(booking_date))
      comment: "Quarter and year of statutory reserve booking"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for statutory reserve governance"
  measures:
    - name: "total_net_statutory_reserve"
      expr: SUM(CAST(net_statutory_reserve_amount AS DOUBLE))
      comment: "Total net statutory reserve after reinsurance ceded"
    - name: "total_gross_statutory_reserve"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross statutory reserve before reinsurance"
    - name: "total_pbr_reserve"
      expr: SUM(CAST(pbr_reserve_amount AS DOUBLE))
      comment: "Total principle-based reserve under VM-20 or VM-21"
    - name: "total_carvm_reserve"
      expr: SUM(CAST(carvm_reserve_amount AS DOUBLE))
      comment: "Total Commissioners Annuity Reserve Valuation Method reserve"
    - name: "total_crvm_reserve"
      expr: SUM(CAST(crvm_reserve_amount AS DOUBLE))
      comment: "Total Commissioners Reserve Valuation Method reserve"
    - name: "total_deficiency_reserve"
      expr: SUM(CAST(deficiency_reserve_amount AS DOUBLE))
      comment: "Total deficiency reserve for inadequate gross premiums"
    - name: "total_reinsurance_ceded_reserve"
      expr: SUM(CAST(reinsurance_ceded_reserve_amount AS DOUBLE))
      comment: "Total statutory reserve ceded to reinsurers"
    - name: "total_rbc_contribution"
      expr: SUM(CAST(rbc_contribution_amount AS DOUBLE))
      comment: "Total risk-based capital contribution from statutory reserves"
    - name: "total_reserve_change"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Total change in statutory reserves from prior period"
    - name: "total_net_amount_at_risk"
      expr: SUM(CAST(net_amount_at_risk AS DOUBLE))
      comment: "Total net amount at risk (face amount minus reserve)"
    - name: "avg_valuation_interest_rate"
      expr: AVG(CAST(valuation_interest_rate AS DOUBLE))
      comment: "Average statutory valuation interest rate"
    - name: "avg_reserve_adequacy_margin"
      expr: AVG(CAST(reserve_adequacy_margin AS DOUBLE))
      comment: "Average reserve adequacy margin as percentage of reserve"
    - name: "statutory_reserve_count"
      expr: COUNT(DISTINCT statutory_reserve_id)
      comment: "Count of distinct statutory reserve records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_rbc_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-based capital adequacy, RBC ratio trends, and regulatory action level monitoring for solvency oversight"
  source: "`life_insurance_ecm`.`finance`.`rbc_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of RBC calculation (e.g., draft, final, filed)"
    - name: "calculation_type"
      expr: calculation_type
      comment: "Type of RBC calculation (e.g., annual, quarterly, ad-hoc)"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for RBC calculation"
    - name: "reporting_quarter"
      expr: reporting_quarter
      comment: "Reporting quarter for RBC calculation"
    - name: "regulator_jurisdiction"
      expr: regulator_jurisdiction
      comment: "State insurance regulator jurisdiction for RBC filing"
    - name: "action_level_trigger"
      expr: action_level_trigger
      comment: "RBC action level triggered (e.g., no action, company action, regulatory action)"
    - name: "trend_test_result"
      expr: trend_test_result
      comment: "Result of RBC trend test (pass/fail)"
    - name: "calculation_methodology"
      expr: calculation_methodology
      comment: "RBC calculation methodology version (e.g., NAIC 2023)"
    - name: "auditor_reviewed_flag"
      expr: auditor_reviewed_flag
      comment: "Indicates whether RBC calculation was reviewed by external auditor"
    - name: "filed_with_regulator_flag"
      expr: filed_with_regulator_flag
      comment: "Indicates whether RBC was filed with state regulator"
    - name: "orsa_alignment_flag"
      expr: orsa_alignment_flag
      comment: "Indicates alignment with Own Risk and Solvency Assessment"
  measures:
    - name: "total_adjusted_capital"
      expr: SUM(CAST(total_adjusted_capital AS DOUBLE))
      comment: "Total adjusted capital available to support risk"
    - name: "total_rbc_before_covariance"
      expr: SUM(CAST(total_rbc_before_covariance AS DOUBLE))
      comment: "Total RBC requirement before covariance adjustment"
    - name: "total_rbc_after_covariance"
      expr: SUM(CAST(total_rbc_after_covariance AS DOUBLE))
      comment: "Total RBC requirement after covariance adjustment"
    - name: "avg_rbc_ratio"
      expr: AVG(CAST(rbc_ratio AS DOUBLE))
      comment: "Average RBC ratio (Total Adjusted Capital / Authorized Control Level RBC)"
    - name: "total_c0_asset_risk_affiliates"
      expr: SUM(CAST(c0_asset_risk_affiliates AS DOUBLE))
      comment: "Total C0 asset risk for affiliated investments"
    - name: "total_c1_asset_risk_fixed_income"
      expr: SUM(CAST(c1_asset_risk_fixed_income AS DOUBLE))
      comment: "Total C1 asset risk for fixed income securities"
    - name: "total_c1_asset_risk_equity"
      expr: SUM(CAST(c1_asset_risk_equity AS DOUBLE))
      comment: "Total C1 asset risk for equity securities"
    - name: "total_c1_asset_risk_real_estate"
      expr: SUM(CAST(c1_asset_risk_real_estate AS DOUBLE))
      comment: "Total C1 asset risk for real estate holdings"
    - name: "total_c2_insurance_risk"
      expr: SUM(CAST(c2_insurance_risk AS DOUBLE))
      comment: "Total C2 insurance risk (mortality, morbidity, lapse)"
    - name: "total_c3_interest_rate_risk"
      expr: SUM(CAST(c3_interest_rate_risk AS DOUBLE))
      comment: "Total C3 interest rate risk"
    - name: "total_c3_market_risk"
      expr: SUM(CAST(c3_market_risk AS DOUBLE))
      comment: "Total C3 market risk"
    - name: "total_c4_business_risk"
      expr: SUM(CAST(c4_business_risk AS DOUBLE))
      comment: "Total C4 business risk"
    - name: "total_covariance_adjustment"
      expr: SUM(CAST(covariance_adjustment AS DOUBLE))
      comment: "Total covariance adjustment reducing RBC requirement"
    - name: "rbc_calculation_count"
      expr: COUNT(DISTINCT rbc_calculation_id)
      comment: "Count of distinct RBC calculation records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_dac_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deferred acquisition cost asset balances, amortization patterns, LDTI cohort tracking, and impairment monitoring for capitalized acquisition expenses"
  source: "`life_insurance_ecm`.`finance`.`dac_asset`"
  dimensions:
    - name: "dac_asset_status"
      expr: dac_asset_status
      comment: "Status of DAC asset (e.g., active, fully amortized, impaired)"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for DAC asset segmentation"
    - name: "issue_year"
      expr: issue_year
      comment: "Policy issue year for DAC cohort grouping"
    - name: "ldti_cohort_grouping_key"
      expr: ldti_cohort_grouping_key
      comment: "LDTI cohort grouping key under ASU 2018-12"
    - name: "amortization_method"
      expr: amortization_method
      comment: "DAC amortization method (e.g., in proportion to gross profits, straight-line)"
    - name: "gaap_reporting_basis"
      expr: gaap_reporting_basis
      comment: "GAAP reporting basis for DAC (e.g., US GAAP, IFRS 17)"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for DAC asset valuation"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of DAC asset (e.g., reconciled, pending)"
    - name: "impairment_indicator_flag"
      expr: impairment_indicator_flag
      comment: "Indicates whether DAC asset shows impairment indicators"
    - name: "external_audit_reviewed_flag"
      expr: external_audit_reviewed_flag
      comment: "Indicates whether DAC asset was reviewed by external auditors"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for DAC asset governance"
  measures:
    - name: "total_unamortized_dac_balance"
      expr: SUM(CAST(unamortized_dac_balance AS DOUBLE))
      comment: "Total unamortized DAC asset balance on balance sheet"
    - name: "total_dac_capitalized"
      expr: SUM(CAST(dac_capitalized_amount AS DOUBLE))
      comment: "Total DAC capitalized during period"
    - name: "total_actual_amortization"
      expr: SUM(CAST(actual_amortization_amount AS DOUBLE))
      comment: "Total actual DAC amortization expense recognized"
    - name: "total_scheduled_amortization"
      expr: SUM(CAST(scheduled_amortization_amount AS DOUBLE))
      comment: "Total scheduled DAC amortization per amortization schedule"
    - name: "total_cumulative_amortization"
      expr: SUM(CAST(cumulative_amortization_balance AS DOUBLE))
      comment: "Total cumulative DAC amortization to date"
    - name: "total_interest_accretion"
      expr: SUM(CAST(interest_accretion_amount AS DOUBLE))
      comment: "Total interest accretion on DAC asset"
    - name: "total_shadow_dac_adjustment"
      expr: SUM(CAST(shadow_dac_adjustment AS DOUBLE))
      comment: "Total shadow DAC adjustment for unrealized gains/losses"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total DAC impairment loss recognized"
    - name: "total_voba_component"
      expr: SUM(CAST(voba_component_amount AS DOUBLE))
      comment: "Total value of business acquired component within DAC"
    - name: "total_voba_amortization"
      expr: SUM(CAST(voba_amortization_amount AS DOUBLE))
      comment: "Total VOBA amortization expense"
    - name: "total_ifrs17_acquisition_cash_flow_asset"
      expr: SUM(CAST(ifrs17_acquisition_cash_flow_asset AS DOUBLE))
      comment: "Total IFRS 17 acquisition cash flow asset"
    - name: "total_variance_from_prior_period"
      expr: SUM(CAST(variance_from_prior_period AS DOUBLE))
      comment: "Total variance in DAC balance from prior period"
    - name: "dac_asset_count"
      expr: COUNT(DISTINCT dac_asset_id)
      comment: "Count of distinct DAC asset records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_ifrs17_contract_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IFRS 17 contractual service margin release, loss component tracking, and insurance revenue recognition for international financial reporting"
  source: "`life_insurance_ecm`.`finance`.`ifrs17_contract_group`"
  dimensions:
    - name: "contract_group_code"
      expr: contract_group_code
      comment: "IFRS 17 contract group identifier"
    - name: "ifrs17_contract_group_status"
      expr: ifrs17_contract_group_status
      comment: "Status of IFRS 17 contract group (e.g., active, derecognized)"
    - name: "measurement_model"
      expr: measurement_model
      comment: "IFRS 17 measurement model (e.g., GMM, PAA, VFA)"
    - name: "profitability_classification"
      expr: profitability_classification
      comment: "Profitability classification (e.g., onerous, non-onerous)"
    - name: "transition_approach"
      expr: transition_approach
      comment: "IFRS 17 transition approach (e.g., full retrospective, modified retrospective, fair value)"
    - name: "oci_pl_allocation_election"
      expr: oci_pl_allocation_election
      comment: "OCI vs P&L allocation election for insurance finance income/expense"
    - name: "coverage_period"
      expr: coverage_period
      comment: "Coverage period for contract group"
    - name: "contract_boundary_assessment"
      expr: contract_boundary_assessment
      comment: "Contract boundary assessment result"
    - name: "reporting_period_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Reporting period year"
    - name: "reporting_period_quarter"
      expr: CONCAT('Q', QUARTER(reporting_period_end_date), '-', YEAR(reporting_period_end_date))
      comment: "Reporting period quarter and year"
  measures:
    - name: "total_closing_csm"
      expr: SUM(CAST(closing_csm_balance AS DOUBLE))
      comment: "Total closing contractual service margin balance"
    - name: "total_opening_csm"
      expr: SUM(CAST(opening_csm_balance AS DOUBLE))
      comment: "Total opening contractual service margin balance"
    - name: "total_csm_release"
      expr: SUM(CAST(csm_release_amount AS DOUBLE))
      comment: "Total CSM released to insurance revenue during period"
    - name: "total_csm_new_business"
      expr: SUM(CAST(csm_new_business_addition AS DOUBLE))
      comment: "Total CSM added from new business written"
    - name: "total_csm_assumption_change"
      expr: SUM(CAST(csm_assumption_change_impact AS DOUBLE))
      comment: "Total CSM impact from assumption changes"
    - name: "total_csm_experience_variance"
      expr: SUM(CAST(csm_experience_variance AS DOUBLE))
      comment: "Total CSM impact from experience variances"
    - name: "total_csm_interest_accretion"
      expr: SUM(CAST(csm_interest_accretion AS DOUBLE))
      comment: "Total interest accretion on CSM"
    - name: "total_insurance_revenue"
      expr: SUM(CAST(insurance_revenue_recognized AS DOUBLE))
      comment: "Total insurance revenue recognized under IFRS 17"
    - name: "total_insurance_service_expense"
      expr: SUM(CAST(insurance_service_expense AS DOUBLE))
      comment: "Total insurance service expense"
    - name: "total_insurance_finance_income_expense"
      expr: SUM(CAST(insurance_finance_income_expense AS DOUBLE))
      comment: "Total insurance finance income or expense"
    - name: "total_loss_component_closing"
      expr: SUM(CAST(loss_component_closing AS DOUBLE))
      comment: "Total closing loss component for onerous contracts"
    - name: "total_risk_adjustment_closing"
      expr: SUM(CAST(risk_adjustment_closing AS DOUBLE))
      comment: "Total closing risk adjustment for non-financial risk"
    - name: "total_risk_adjustment_release"
      expr: SUM(CAST(risk_adjustment_release AS DOUBLE))
      comment: "Total risk adjustment released during period"
    - name: "total_oci_amount"
      expr: SUM(CAST(oci_amount AS DOUBLE))
      comment: "Total other comprehensive income amount"
    - name: "avg_discount_rate_closing"
      expr: AVG(CAST(discount_rate_closing AS DOUBLE))
      comment: "Average closing discount rate"
    - name: "contract_group_count"
      expr: COUNT(DISTINCT ifrs17_contract_group_id)
      comment: "Count of distinct IFRS 17 contract groups"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_budget_variance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget vs actual variance analysis, favorable/unfavorable classification, and management commentary tracking for financial planning and analysis"
  source: "`life_insurance_ecm`.`finance`.`budget_variance`"
  dimensions:
    - name: "variance_status"
      expr: variance_status
      comment: "Status of budget variance (e.g., under review, approved, closed)"
    - name: "favorable_unfavorable_indicator"
      expr: favorable_unfavorable_indicator
      comment: "Indicates whether variance is favorable or unfavorable to budget"
    - name: "reporting_category"
      expr: reporting_category
      comment: "Reporting category for variance analysis (e.g., operating, capital)"
    - name: "gaap_expense_category"
      expr: gaap_expense_category
      comment: "GAAP expense category for variance classification"
    - name: "sap_expense_exhibit"
      expr: sap_expense_exhibit
      comment: "SAP annual statement exhibit line for variance"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category impacted by variance"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for variance"
    - name: "variance_threshold_exceeded_flag"
      expr: variance_threshold_exceeded_flag
      comment: "Indicates whether variance exceeded management threshold"
    - name: "dac_eligible_flag"
      expr: dac_eligible_flag
      comment: "Indicates whether variance relates to DAC-eligible expenses"
    - name: "sox_controlled_flag"
      expr: sox_controlled_flag
      comment: "SOX control flag for variance governance"
    - name: "intercompany_settlement_flag"
      expr: intercompany_settlement_flag
      comment: "Indicates whether variance involves intercompany settlement"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual amount incurred"
    - name: "total_reforecast_amount"
      expr: SUM(CAST(reforecast_amount AS DOUBLE))
      comment: "Total reforecast amount"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount (actual minus budget)"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage"
    - name: "budget_variance_count"
      expr: COUNT(DISTINCT budget_variance_id)
      comment: "Count of distinct budget variance records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry volume, posting timeliness, reversal tracking, and SOX control compliance for general ledger integrity"
  source: "`life_insurance_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of journal entry (e.g., draft, posted, reversed)"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of journal entry (e.g., standard, adjusting, closing, reversing)"
    - name: "entry_category"
      expr: entry_category
      comment: "Category of journal entry (e.g., accrual, reclassification, correction)"
    - name: "accounting_basis"
      expr: accounting_basis
      comment: "Accounting basis for entry (e.g., GAAP, SAP, IFRS)"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for journal entry"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of journal entry"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for journal entry segmentation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether entry is a reversal"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates whether entry involves intercompany transactions"
    - name: "ldti_indicator"
      expr: ldti_indicator
      comment: "Indicates whether entry relates to LDTI accounting"
    - name: "pbr_indicator"
      expr: pbr_indicator
      comment: "Indicates whether entry relates to principle-based reserves"
    - name: "ifrs17_measurement_model"
      expr: ifrs17_measurement_model
      comment: "IFRS 17 measurement model for entry"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month of journal entry date"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount across journal entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount across journal entries"
    - name: "total_functional_currency_debit"
      expr: SUM(CAST(functional_currency_debit AS DOUBLE))
      comment: "Total functional currency debit amount"
    - name: "total_functional_currency_credit"
      expr: SUM(CAST(functional_currency_credit AS DOUBLE))
      comment: "Total functional currency credit amount"
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to journal entries"
    - name: "journal_entry_count"
      expr: COUNT(DISTINCT journal_entry_id)
      comment: "Count of distinct journal entries"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_reinsurance_recoverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance recoverable aging, collectibility assessment, and credit risk monitoring for ceded reinsurance asset management"
  source: "`life_insurance_ecm`.`finance`.`reinsurance_recoverable`"
  dimensions:
    - name: "recoverable_status"
      expr: recoverable_status
      comment: "Status of reinsurance recoverable (e.g., billed, collected, disputed)"
    - name: "recoverable_type"
      expr: recoverable_type
      comment: "Type of reinsurance recoverable (e.g., claim, reserve, commission)"
    - name: "accounting_basis"
      expr: accounting_basis
      comment: "Accounting basis for recoverable (e.g., GAAP, SAP)"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for recoverable"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of recoverable"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of recoverable"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for recoverable segmentation"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket for receivable (e.g., 0-30 days, 31-60 days, 60+ days)"
    - name: "reinsurer_credit_rating"
      expr: reinsurer_credit_rating
      comment: "Credit rating of reinsurer"
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral held (e.g., letter of credit, trust account)"
    - name: "gaap_classification"
      expr: gaap_classification
      comment: "GAAP classification of recoverable"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category for recoverable"
    - name: "sox_controlled_flag"
      expr: sox_controlled_flag
      comment: "SOX control flag for recoverable governance"
  measures:
    - name: "total_gross_recoverable"
      expr: SUM(CAST(gross_recoverable_amount AS DOUBLE))
      comment: "Total gross reinsurance recoverable before allowance"
    - name: "total_net_recoverable"
      expr: SUM(CAST(net_recoverable_amount AS DOUBLE))
      comment: "Total net reinsurance recoverable after allowance for uncollectible"
    - name: "total_allowance_for_uncollectible"
      expr: SUM(CAST(allowance_for_uncollectible AS DOUBLE))
      comment: "Total allowance for uncollectible reinsurance"
    - name: "total_collateral_held"
      expr: SUM(CAST(collateral_held_amount AS DOUBLE))
      comment: "Total collateral held against reinsurance recoverable"
    - name: "total_ifrs17_csm_impact"
      expr: SUM(CAST(ifrs17_csm_impact AS DOUBLE))
      comment: "Total IFRS 17 CSM impact from reinsurance held"
    - name: "reinsurance_recoverable_count"
      expr: COUNT(DISTINCT reinsurance_recoverable_id)
      comment: "Count of distinct reinsurance recoverable records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision adequacy, effective tax rate analysis, deferred tax position monitoring, and uncertain tax position reserve tracking for income tax accounting"
  source: "`life_insurance_ecm`.`finance`.`tax_provision`"
  dimensions:
    - name: "provision_status"
      expr: provision_status
      comment: "Status of tax provision (e.g., preliminary, final, filed)"
    - name: "provision_method"
      expr: provision_method
      comment: "Method used for tax provision calculation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of tax provision"
    - name: "gaap_reporting_basis"
      expr: gaap_reporting_basis
      comment: "GAAP reporting basis for tax provision"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of tax provision"
    - name: "external_auditor_reviewed_flag"
      expr: external_auditor_reviewed_flag
      comment: "Indicates whether tax provision was reviewed by external auditor"
    - name: "sox_control_certification"
      expr: sox_control_certification
      comment: "SOX control certification flag for tax provision"
    - name: "tax_return_filed_flag"
      expr: tax_return_filed_flag
      comment: "Indicates whether tax return has been filed"
    - name: "provision_year"
      expr: YEAR(provision_date)
      comment: "Year of tax provision date"
    - name: "provision_quarter"
      expr: CONCAT('Q', QUARTER(provision_date), '-', YEAR(provision_date))
      comment: "Quarter and year of tax provision"
  measures:
    - name: "total_current_tax_expense"
      expr: SUM(CAST(current_tax_expense AS DOUBLE))
      comment: "Total current tax expense for the period"
    - name: "total_deferred_tax_expense"
      expr: SUM(CAST(deferred_tax_expense AS DOUBLE))
      comment: "Total deferred tax expense for the period"
    - name: "total_tax_expense"
      expr: SUM(CAST(total_tax_expense AS DOUBLE))
      comment: "Total income tax expense (current plus deferred)"
    - name: "total_state_tax_expense"
      expr: SUM(CAST(state_tax_expense AS DOUBLE))
      comment: "Total state income tax expense"
    - name: "total_foreign_tax_expense"
      expr: SUM(CAST(foreign_tax_expense AS DOUBLE))
      comment: "Total foreign income tax expense"
    - name: "total_pretax_income"
      expr: SUM(CAST(pretax_income AS DOUBLE))
      comment: "Total pretax income subject to tax"
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate"
    - name: "avg_statutory_tax_rate"
      expr: AVG(CAST(statutory_tax_rate AS DOUBLE))
      comment: "Average statutory tax rate"
    - name: "total_dta_balance"
      expr: SUM(CAST(dta_balance AS DOUBLE))
      comment: "Total deferred tax asset balance"
    - name: "total_dtl_balance"
      expr: SUM(CAST(dtl_balance AS DOUBLE))
      comment: "Total deferred tax liability balance"
    - name: "total_net_deferred_tax_position"
      expr: SUM(CAST(net_deferred_tax_position AS DOUBLE))
      comment: "Total net deferred tax position (DTA minus DTL)"
    - name: "total_valuation_allowance"
      expr: SUM(CAST(valuation_allowance AS DOUBLE))
      comment: "Total valuation allowance against deferred tax assets"
    - name: "total_utp_reserve"
      expr: SUM(CAST(utp_reserve AS DOUBLE))
      comment: "Total uncertain tax position reserve"
    - name: "total_nol_carryforward"
      expr: SUM(CAST(nol_carryforward AS DOUBLE))
      comment: "Total net operating loss carryforward"
    - name: "total_tax_credit_carryforward"
      expr: SUM(CAST(tax_credit_carryforward AS DOUBLE))
      comment: "Total tax credit carryforward"
    - name: "total_ldti_tax_impact"
      expr: SUM(CAST(ldti_tax_impact AS DOUBLE))
      comment: "Total tax impact from LDTI adoption"
    - name: "tax_provision_count"
      expr: COUNT(DISTINCT tax_provision_id)
      comment: "Count of distinct tax provision records"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`finance_embedded_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Embedded value movement analysis, new business value contribution, and economic variance decomposition for shareholder value reporting"
  source: "`life_insurance_ecm`.`finance`.`embedded_value`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of embedded value calculation (e.g., preliminary, final, published)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of embedded value calculation"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of embedded value calculation"
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line code for embedded value segmentation"
    - name: "reporting_basis"
      expr: reporting_basis
      comment: "Reporting basis for embedded value (e.g., MCEV, EEV, traditional EV)"
    - name: "covered_business_indicator"
      expr: covered_business_indicator
      comment: "Indicates whether business is included in embedded value calculation"
    - name: "external_audit_reviewed_flag"
      expr: external_audit_reviewed_flag
      comment: "Indicates whether embedded value was reviewed by external auditor"
    - name: "investor_disclosure_flag"
      expr: investor_disclosure_flag
      comment: "Indicates whether embedded value is disclosed to investors"
    - name: "sensitivity_test_performed_flag"
      expr: sensitivity_test_performed_flag
      comment: "Indicates whether sensitivity testing was performed"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of embedded value valuation date"
  measures:
    - name: "total_closing_embedded_value"
      expr: SUM(CAST(closing_embedded_value AS DOUBLE))
      comment: "Total closing embedded value"
    - name: "total_opening_embedded_value"
      expr: SUM(CAST(opening_embedded_value AS DOUBLE))
      comment: "Total opening embedded value"
    - name: "total_new_business_value"
      expr: SUM(CAST(new_business_value AS DOUBLE))
      comment: "Total value of new business written during period"
    - name: "total_expected_return"
      expr: SUM(CAST(expected_return AS DOUBLE))
      comment: "Total expected return on embedded value"
    - name: "total_experience_variance"
      expr: SUM(CAST(experience_variance AS DOUBLE))
      comment: "Total experience variance from expected"
    - name: "total_assumption_change_impact"
      expr: SUM(CAST(assumption_change_impact AS DOUBLE))
      comment: "Total impact of assumption changes on embedded value"
    - name: "total_economic_variance"
      expr: SUM(CAST(economic_variance AS DOUBLE))
      comment: "Total economic variance (interest rates, equity markets)"
    - name: "total_other_operating_variance"
      expr: SUM(CAST(other_operating_variance AS DOUBLE))
      comment: "Total other operating variance"
    - name: "total_capital_movements"
      expr: SUM(CAST(capital_movements AS DOUBLE))
      comment: "Total capital movements (dividends, capital injections)"
    - name: "total_value_of_in_force"
      expr: SUM(CAST(value_of_in_force AS DOUBLE))
      comment: "Total value of in-force business"
    - name: "total_adjusted_net_worth"
      expr: SUM(CAST(adjusted_net_worth AS DOUBLE))
      comment: "Total adjusted net worth"
    - name: "total_free_surplus"
      expr: SUM(CAST(free_surplus AS DOUBLE))
      comment: "Total free surplus available for distribution"
    - name: "total_required_capital"
      expr: SUM(CAST(required_capital_amount AS DOUBLE))
      comment: "Total required capital held"
    - name: "total_cost_of_required_capital"
      expr: SUM(CAST(cost_of_required_capital AS DOUBLE))
      comment: "Total cost of holding required capital"
    - name: "total_frictional_costs"
      expr: SUM(CAST(frictional_costs AS DOUBLE))
      comment: "Total frictional costs of holding capital"
    - name: "total_time_value_financial_options"
      expr: SUM(CAST(time_value_financial_options_guarantees AS DOUBLE))
      comment: "Total time value of financial options and guarantees"
    - name: "avg_risk_discount_rate"
      expr: AVG(CAST(risk_discount_rate AS DOUBLE))
      comment: "Average risk discount rate applied"
    - name: "avg_reference_rate"
      expr: AVG(CAST(reference_rate AS DOUBLE))
      comment: "Average reference rate used in calculation"
    - name: "embedded_value_count"
      expr: COUNT(DISTINCT embedded_value_id)
      comment: "Count of distinct embedded value calculation records"
$$;