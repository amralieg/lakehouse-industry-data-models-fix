-- Metric views for domain: owner | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_capital_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks equity capital deployment activity across owners, assets, and funds. Supports LP/GP capital call monitoring, funding compliance, and equity waterfall analysis."
  source: "`real_estate_ecm`.`owner`.`capital_contribution`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of capital contribution (e.g., initial, follow-on, recallable) for segmenting equity deployment by category."
    - name: "contribution_status"
      expr: contribution_status
      comment: "Current status of the contribution (e.g., funded, pending, defaulted) for pipeline and compliance monitoring."
    - name: "equity_tier"
      expr: equity_tier
      comment: "Equity tier (e.g., preferred, common, mezzanine) to analyze capital structure and waterfall positioning."
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Source of funding (e.g., wire, ACH, in-kind) for treasury and reconciliation analysis."
    - name: "investor_entity_type"
      expr: investor_entity_type
      comment: "Legal entity type of the investor (e.g., individual, trust, institution) for investor segmentation."
    - name: "contribution_date"
      expr: DATE_TRUNC('month', contribution_date)
      comment: "Month of contribution date for time-series trend analysis of capital inflows."
    - name: "capex_category"
      expr: capex_category
      comment: "CapEx category associated with the contribution for capital allocation analysis."
    - name: "is_late_funding"
      expr: is_late_funding
      comment: "Flag indicating whether the contribution was funded after the capital call due date, used for default risk monitoring."
    - name: "kyc_verified"
      expr: kyc_verified
      comment: "KYC verification status of the contributing investor for compliance segmentation."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the contribution, enabling period-over-period financial reporting."
  measures:
    - name: "total_contribution_amount_usd"
      expr: SUM(CAST(contribution_amount_usd AS DOUBLE))
      comment: "Total capital contributed in USD across all owners and assets. Primary KPI for equity deployment tracking and fund capital call fulfillment."
    - name: "total_net_contribution_amount"
      expr: SUM(CAST(net_contribution_amount AS DOUBLE))
      comment: "Total net capital contributed after deducting tax withholdings and fees. Reflects actual equity deployed into the structure."
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withheld on capital contributions. Critical for FIRPTA, FATCA, and cross-border investor compliance reporting."
    - name: "total_default_interest_amount"
      expr: SUM(CAST(default_interest_amount AS DOUBLE))
      comment: "Total default interest accrued on late capital contributions. Signals LP funding discipline and potential dilution events."
    - name: "total_unfunded_commitment"
      expr: SUM(CAST(unfunded_commitment_after AS DOUBLE))
      comment: "Total remaining unfunded capital commitment after each contribution event. Key metric for fund liquidity planning and capital call scheduling."
    - name: "avg_contribution_amount_usd"
      expr: AVG(CAST(contribution_amount_usd AS DOUBLE))
      comment: "Average capital contribution per event in USD. Useful for benchmarking investor participation size and identifying outliers."
    - name: "late_funding_contribution_count"
      expr: COUNT(CASE WHEN is_late_funding = TRUE THEN capital_contribution_id END)
      comment: "Number of capital contributions funded after the due date. Drives LP default risk assessment and penalty enforcement decisions."
    - name: "total_contribution_count"
      expr: COUNT(1)
      comment: "Total number of capital contribution events. Baseline volume metric for capital call activity monitoring."
    - name: "avg_preferred_return_rate"
      expr: AVG(CAST(preferred_return_rate AS DOUBLE))
      comment: "Average preferred return rate across contributions. Informs fund cost-of-capital benchmarking and investor return expectations."
    - name: "total_called_amount"
      expr: SUM(CAST(called_amount AS DOUBLE))
      comment: "Total capital called from investors across all capital call events. Measures fund draw-down velocity against committed capital."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master owner registry metrics for investor profiling, onboarding pipeline management, compliance status, and portfolio targeting analysis."
  source: "`real_estate_ecm`.`owner`.`owner`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the owner (e.g., individual, LLC, REIT, pension fund) for investor segmentation."
    - name: "owner_class"
      expr: owner_class
      comment: "Owner classification (e.g., institutional, retail, family office) for tiered service and reporting."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status (e.g., pending, active, rejected) for pipeline conversion tracking."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC compliance status of the owner for regulatory risk segmentation."
    - name: "aum_tier"
      expr: aum_tier
      comment: "AUM tier of the owner for investor value segmentation and relationship management prioritization."
    - name: "risk_tolerance"
      expr: risk_tolerance
      comment: "Owner's stated risk tolerance (e.g., conservative, moderate, aggressive) for portfolio alignment analysis."
    - name: "distribution_frequency"
      expr: distribution_frequency
      comment: "Preferred distribution frequency (e.g., monthly, quarterly, annual) for cash flow planning."
    - name: "fatca_status"
      expr: fatca_status
      comment: "FATCA compliance classification for cross-border tax reporting and withholding obligations."
    - name: "onboarding_date"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month of owner onboarding for cohort analysis and investor acquisition trend tracking."
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of owner domicile for geographic concentration and regulatory jurisdiction analysis."
  measures:
    - name: "total_owner_count"
      expr: COUNT(1)
      comment: "Total number of registered owners. Baseline metric for investor base size and growth tracking."
    - name: "active_owner_count"
      expr: COUNT(CASE WHEN onboarding_status = 'active' THEN owner_id END)
      comment: "Number of fully onboarded and active owners. Measures the productive investor base available for capital deployment."
    - name: "kyc_verified_owner_count"
      expr: COUNT(CASE WHEN kyc_status = 'verified' THEN owner_id END)
      comment: "Number of owners with verified KYC status. Critical compliance metric for AML/KYC regulatory adherence."
    - name: "accredited_investor_count"
      expr: COUNT(CASE WHEN accredited_investor_flag = TRUE THEN owner_id END)
      comment: "Number of owners qualifying as accredited investors. Determines eligibility for private placement offerings under SEC Reg D."
    - name: "qualified_purchaser_count"
      expr: COUNT(CASE WHEN qualified_purchaser_flag = TRUE THEN owner_id END)
      comment: "Number of owners qualifying as qualified purchasers. Enables access to Section 3(c)(7) fund structures with higher AUM thresholds."
    - name: "avg_target_irr_pct"
      expr: AVG(CAST(target_irr_pct AS DOUBLE))
      comment: "Average target IRR across all owners. Benchmarks investor return expectations against fund performance for alignment analysis."
    - name: "avg_target_cap_rate_pct"
      expr: AVG(CAST(target_cap_rate_pct AS DOUBLE))
      comment: "Average target cap rate across owners. Informs asset acquisition strategy and pricing alignment with investor expectations."
    - name: "avg_beneficial_ownership_pct"
      expr: AVG(CAST(beneficial_ownership_pct AS DOUBLE))
      comment: "Average beneficial ownership percentage across owners. Supports FinCEN beneficial ownership disclosure compliance."
    - name: "politically_exposed_owner_count"
      expr: COUNT(CASE WHEN politically_exposed_flag = TRUE THEN owner_id END)
      comment: "Number of politically exposed persons (PEPs) in the owner registry. Drives enhanced due diligence and AML risk escalation."
    - name: "sanctions_screened_owner_count"
      expr: COUNT(CASE WHEN sanctions_screened_flag = TRUE THEN owner_id END)
      comment: "Number of owners who have completed sanctions screening. Measures OFAC/sanctions compliance coverage across the investor base."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks cash distributions to property owners including gross amounts, withholding taxes, net disbursements, and distribution pipeline status. Core KPI layer for investor relations and cash management."
  source: "`real_estate_ecm`.`owner`.`owner_distribution`"
  dimensions:
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g., operating income, return of capital, sale proceeds) for waterfall and tax classification."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (e.g., approved, disbursed, reversed) for payment pipeline monitoring."
    - name: "frequency"
      expr: frequency
      comment: "Distribution frequency (e.g., monthly, quarterly) for cash flow cadence analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., wire, ACH, check) for treasury operations and bank reconciliation."
    - name: "is_foreign_owner"
      expr: is_foreign_owner
      comment: "Flag indicating foreign ownership status, driving FIRPTA withholding and cross-border tax compliance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the distribution for governance and authorization tracking."
    - name: "distribution_date"
      expr: DATE_TRUNC('month', distribution_date)
      comment: "Month of distribution date for time-series cash outflow trend analysis."
    - name: "k1_tax_year"
      expr: k1_tax_year
      comment: "Tax year associated with the K-1 distribution for annual tax reporting and investor statement preparation."
    - name: "calculation_period_start_date"
      expr: DATE_TRUNC('quarter', calculation_period_start_date)
      comment: "Quarter of the distribution calculation period for quarterly performance reporting."
  measures:
    - name: "total_gross_distribution_amount"
      expr: SUM(CAST(gross_distribution_amount AS DOUBLE))
      comment: "Total gross distributions paid to owners before withholding. Primary KPI for investor cash return and fund distribution performance."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net cash disbursed to owners after withholding taxes. Reflects actual cash outflow and investor net return."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total tax withheld on distributions. Critical for FIRPTA, FATCA, and state withholding compliance reporting."
    - name: "total_distributable_noi_amount"
      expr: SUM(CAST(distributable_noi_amount AS DOUBLE))
      comment: "Total distributable net operating income across all distribution events. Links property operating performance to investor cash returns."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied across distributions. Benchmarks tax efficiency and identifies high-withholding investor segments."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across distribution recipients. Measures ownership concentration in distribution events."
    - name: "distribution_count"
      expr: COUNT(1)
      comment: "Total number of distribution events processed. Baseline volume metric for distribution operations throughput."
    - name: "foreign_owner_distribution_count"
      expr: COUNT(CASE WHEN is_foreign_owner = TRUE THEN owner_distribution_id END)
      comment: "Number of distributions to foreign owners. Drives FIRPTA withholding compliance and cross-border tax reporting workload."
    - name: "distinct_owner_distribution_count"
      expr: COUNT(DISTINCT owner_id)
      comment: "Number of distinct owners receiving distributions. Measures breadth of investor participation in distribution events."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_ownership_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks ownership interest positions across assets, funds, and structures. Supports equity position management, vesting schedules, encumbrance monitoring, and ownership lifecycle analysis."
  source: "`real_estate_ecm`.`owner`.`owner_ownership_interest`"
  dimensions:
    - name: "interest_type"
      expr: interest_type
      comment: "Type of ownership interest (e.g., fee simple, leasehold, fractional) for position classification."
    - name: "owner_ownership_interest_status"
      expr: owner_ownership_interest_status
      comment: "Current status of the ownership interest (e.g., active, disposed, transferred) for portfolio position monitoring."
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of encumbrance on the interest (e.g., mortgage, lien, pledge) for debt and collateral risk analysis."
    - name: "vesting_type"
      expr: vesting_type
      comment: "Vesting schedule type for the ownership interest, relevant for promote and carried interest structures."
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC compliance status at the ownership interest level for regulatory position-level compliance."
    - name: "controlling_interest_flag"
      expr: controlling_interest_flag
      comment: "Flag indicating whether the interest represents a controlling stake, relevant for consolidation and governance analysis."
    - name: "jv_structure_flag"
      expr: jv_structure_flag
      comment: "Flag indicating joint venture structure, used to segment JV positions for partnership reporting."
    - name: "acquisition_date"
      expr: DATE_TRUNC('year', acquisition_date)
      comment: "Year of interest acquisition for vintage analysis and hold period performance tracking."
    - name: "vesting_schedule_flag"
      expr: vesting_schedule_flag
      comment: "Indicates whether a vesting schedule applies to the interest, relevant for promote and incentive structure monitoring."
  measures:
    - name: "total_equity_value_amount"
      expr: SUM(CAST(equity_value_amount AS DOUBLE))
      comment: "Total equity value across all ownership interests. Primary KPI for portfolio equity position sizing and NAV contribution."
    - name: "total_cost_basis_amount"
      expr: SUM(CAST(cost_basis_amount AS DOUBLE))
      comment: "Total cost basis of ownership interests. Essential for unrealized gain/loss calculation and tax basis tracking."
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbrance value against ownership interests. Measures leverage and collateral exposure across the portfolio."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across all interest positions. Indicates ownership concentration and diversification across assets."
    - name: "active_interest_count"
      expr: COUNT(CASE WHEN owner_ownership_interest_status = 'active' THEN owner_ownership_interest_id END)
      comment: "Number of currently active ownership interest positions. Measures the live portfolio position count for asset management oversight."
    - name: "controlling_interest_count"
      expr: COUNT(CASE WHEN controlling_interest_flag = TRUE THEN owner_ownership_interest_id END)
      comment: "Number of controlling ownership interests. Identifies assets where the owner holds decision-making authority for governance reporting."
    - name: "distinct_asset_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets in which ownership interests are held. Measures portfolio breadth and diversification."
    - name: "avg_equity_value_amount"
      expr: AVG(CAST(equity_value_amount AS DOUBLE))
      comment: "Average equity value per ownership interest position. Benchmarks position sizing and identifies concentration risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_ownership_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyzes ownership vehicle structures (LLCs, LPs, REITs, JVs) including AUM, capital commitments, target returns, and structural characteristics. Supports fund strategy and investor reporting."
  source: "`real_estate_ecm`.`owner`.`ownership_structure`"
  dimensions:
    - name: "structure_type"
      expr: structure_type
      comment: "Legal structure type (e.g., LLC, LP, REIT, TIC) for entity classification and regulatory reporting."
    - name: "ownership_structure_status"
      expr: ownership_structure_status
      comment: "Current status of the ownership structure (e.g., active, dissolved, winding-down) for portfolio lifecycle monitoring."
    - name: "investment_strategy"
      expr: investment_strategy
      comment: "Investment strategy of the structure (e.g., core, value-add, opportunistic) for strategy-level performance benchmarking."
    - name: "esg_classification"
      expr: esg_classification
      comment: "ESG classification of the structure for sustainable investment reporting and mandate compliance."
    - name: "distribution_frequency"
      expr: distribution_frequency
      comment: "Distribution frequency of the structure for cash flow planning and investor expectation management."
    - name: "reit_qualified"
      expr: reit_qualified
      comment: "Flag indicating REIT qualification status for tax-advantaged structure identification and compliance."
    - name: "publicly_traded"
      expr: publicly_traded
      comment: "Flag indicating whether the structure is publicly traded for market vs. private capital segmentation."
    - name: "formation_date"
      expr: DATE_TRUNC('year', formation_date)
      comment: "Year of structure formation for vintage analysis and fund lifecycle tracking."
    - name: "managing_member_entity_type"
      expr: managing_member_entity_type
      comment: "Entity type of the managing member (GP) for governance and sponsor segmentation."
  measures:
    - name: "total_aum"
      expr: SUM(CAST(aum AS DOUBLE))
      comment: "Total assets under management across all ownership structures. Primary KPI for firm-level AUM reporting and growth tracking."
    - name: "total_committed_capital"
      expr: SUM(CAST(total_committed_capital AS DOUBLE))
      comment: "Total committed capital across all structures. Measures fundraising success and capital pipeline for deployment planning."
    - name: "total_contributed_capital"
      expr: SUM(CAST(total_contributed_capital AS DOUBLE))
      comment: "Total capital actually contributed into structures. Measures funded equity deployed versus committed, indicating draw-down velocity."
    - name: "avg_target_irr"
      expr: AVG(CAST(target_irr AS DOUBLE))
      comment: "Average target IRR across ownership structures. Benchmarks return expectations against realized performance for investor reporting."
    - name: "avg_target_equity_multiple"
      expr: AVG(CAST(target_equity_multiple AS DOUBLE))
      comment: "Average target equity multiple across structures. Key investor return metric for fund marketing and performance benchmarking."
    - name: "avg_preferred_return_rate"
      expr: AVG(CAST(preferred_return_rate AS DOUBLE))
      comment: "Average preferred return rate (hurdle rate) across structures. Informs cost-of-capital analysis and waterfall distribution modeling."
    - name: "avg_promote_percentage"
      expr: AVG(CAST(promote_percentage AS DOUBLE))
      comment: "Average promote (carried interest) percentage across structures. Measures GP incentive alignment and compensation structure."
    - name: "active_structure_count"
      expr: COUNT(CASE WHEN ownership_structure_status = 'active' THEN ownership_structure_id END)
      comment: "Number of currently active ownership structures. Measures the live fund and vehicle count under management."
    - name: "reit_qualified_structure_count"
      expr: COUNT(CASE WHEN reit_qualified = TRUE THEN ownership_structure_id END)
      comment: "Number of REIT-qualified structures. Tracks tax-advantaged vehicle count for REIT compliance and investor tax reporting."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_ownership_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks ownership transfer transactions including consideration amounts, transfer taxes, LTV ratios, and compliance status. Supports transaction volume, deal economics, and regulatory reporting."
  source: "`real_estate_ecm`.`owner`.`ownership_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the ownership transfer (e.g., pending, recorded, cancelled) for transaction pipeline monitoring."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC verification status at the transfer level for AML compliance and beneficial ownership disclosure."
    - name: "capital_gains_flag"
      expr: capital_gains_flag
      comment: "Flag indicating whether the transfer triggers a capital gains event for tax planning and reporting."
    - name: "beneficial_owner_disclosed"
      expr: beneficial_owner_disclosed
      comment: "Flag indicating beneficial ownership disclosure compliance at the transfer level for FinCEN reporting."
    - name: "transfer_date"
      expr: DATE_TRUNC('quarter', transfer_date)
      comment: "Quarter of transfer date for transaction volume trend analysis and market activity reporting."
    - name: "recording_date"
      expr: DATE_TRUNC('year', recording_date)
      comment: "Year of deed recording for annual transaction volume and market activity benchmarking."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the transfer record for data lineage and reconciliation."
  measures:
    - name: "total_consideration_amount"
      expr: SUM(CAST(consideration_amount AS DOUBLE))
      comment: "Total transaction consideration (purchase price) across all ownership transfers. Primary KPI for transaction volume and market activity."
    - name: "total_transfer_tax_amount"
      expr: SUM(CAST(transfer_tax_amount AS DOUBLE))
      comment: "Total transfer taxes paid across all transactions. Measures tax cost of ownership transfers for deal economics and jurisdiction analysis."
    - name: "total_transfer_costs_amount"
      expr: SUM(CAST(transfer_costs_amount AS DOUBLE))
      comment: "Total transaction costs (closing costs, legal, title) across transfers. Measures friction cost of ownership transfers."
    - name: "total_loan_amount"
      expr: SUM(CAST(loan_amount AS DOUBLE))
      comment: "Total debt financing associated with ownership transfers. Measures leverage deployed in acquisition transactions."
    - name: "total_tax_basis_amount"
      expr: SUM(CAST(tax_basis_amount AS DOUBLE))
      comment: "Total tax basis of transferred assets. Essential for capital gains calculation and 1031 exchange tracking."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across ownership transfers. Key risk metric for leverage monitoring and lender covenant compliance."
    - name: "avg_transfer_percentage"
      expr: AVG(CAST(transfer_percentage AS DOUBLE))
      comment: "Average percentage of ownership transferred per transaction. Indicates whether transfers are full dispositions or partial interest sales."
    - name: "transfer_count"
      expr: COUNT(1)
      comment: "Total number of ownership transfer transactions. Baseline volume metric for transaction activity and market velocity."
    - name: "capital_gains_transfer_count"
      expr: COUNT(CASE WHEN capital_gains_flag = TRUE THEN ownership_transfer_id END)
      comment: "Number of transfers triggering capital gains events. Drives tax planning, 1031 exchange strategy, and investor tax reporting."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks owner management agreements including fee structures, approval thresholds, renewal pipelines, and compliance flags. Supports contract governance, fee revenue analysis, and agreement lifecycle management."
  source: "`real_estate_ecm`.`owner`.`owner_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the owner agreement (e.g., active, expired, terminated) for contract lifecycle monitoring."
    - name: "management_fee_basis"
      expr: management_fee_basis
      comment: "Basis for management fee calculation (e.g., gross revenue, AUM, fixed) for fee structure analysis."
    - name: "fee_payment_frequency"
      expr: fee_payment_frequency
      comment: "Frequency of fee payments (e.g., monthly, quarterly) for revenue recognition and cash flow planning."
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Flag indicating whether the agreement includes a renewal option for contract retention and pipeline forecasting."
    - name: "incentive_fee_flag"
      expr: incentive_fee_flag
      comment: "Flag indicating whether an incentive fee (performance fee) applies for performance-linked revenue analysis."
    - name: "esg_compliance_flag"
      expr: esg_compliance_flag
      comment: "Flag indicating ESG compliance requirements in the agreement for sustainable mandate tracking."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the agreement became effective for contract vintage and cohort analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of owner reporting obligations (e.g., monthly, quarterly) for reporting workload planning."
  measures:
    - name: "total_management_fee_fixed_amount"
      expr: SUM(CAST(management_fee_fixed_amount AS DOUBLE))
      comment: "Total fixed management fee revenue contracted across all owner agreements. Primary KPI for recurring fee revenue forecasting."
    - name: "avg_management_fee_pct"
      expr: AVG(CAST(management_fee_pct AS DOUBLE))
      comment: "Average management fee percentage across agreements. Benchmarks fee competitiveness and pricing strategy."
    - name: "avg_incentive_fee_pct"
      expr: AVG(CAST(incentive_fee_pct AS DOUBLE))
      comment: "Average incentive fee percentage across performance-linked agreements. Measures performance fee upside potential."
    - name: "avg_incentive_fee_hurdle_rate_pct"
      expr: AVG(CAST(incentive_fee_hurdle_rate_pct AS DOUBLE))
      comment: "Average hurdle rate for incentive fees. Benchmarks performance thresholds required before incentive fees are earned."
    - name: "total_termination_fee_amount"
      expr: SUM(CAST(termination_fee_amount AS DOUBLE))
      comment: "Total termination fees contractually obligated across agreements. Measures revenue protection from early termination events."
    - name: "avg_capex_approval_threshold"
      expr: AVG(CAST(capex_approval_threshold AS DOUBLE))
      comment: "Average CapEx approval threshold across agreements. Informs delegation of authority benchmarking and owner control analysis."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN owner_agreement_id END)
      comment: "Number of currently active owner agreements. Measures the live managed contract portfolio size."
    - name: "incentive_fee_agreement_count"
      expr: COUNT(CASE WHEN incentive_fee_flag = TRUE THEN owner_agreement_id END)
      comment: "Number of agreements with performance-linked incentive fees. Measures the proportion of fee revenue tied to performance outcomes."
    - name: "distinct_owner_agreement_count"
      expr: COUNT(DISTINCT owner_id)
      comment: "Number of distinct owners with active agreements. Measures client base breadth for relationship management."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`owner_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks property and investment tax obligations including assessed taxes, payments, penalties, K-1 allocations, and withholding. Supports tax compliance, liability forecasting, and investor tax reporting."
  source: "`real_estate_ecm`.`owner`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., property tax, transfer tax, income tax, withholding) for tax liability categorization."
    - name: "filing_status"
      expr: filing_status
      comment: "Current filing status (e.g., filed, pending, overdue) for compliance deadline monitoring."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any tax appeal (e.g., filed, pending, resolved) for tax savings opportunity tracking."
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax exemption status for identifying tax-advantaged positions and abatement opportunities."
    - name: "is_foreign_owner"
      expr: is_foreign_owner
      comment: "Flag indicating foreign ownership for FIRPTA withholding and cross-border tax compliance segmentation."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual tax liability trend analysis and year-over-year comparison."
    - name: "tax_period_start_date"
      expr: DATE_TRUNC('year', tax_period_start_date)
      comment: "Year of tax period start for annual tax obligation trend analysis."
    - name: "jurisdiction_county_district"
      expr: jurisdiction_county_district
      comment: "County or tax district for geographic tax burden analysis and jurisdiction benchmarking."
  measures:
    - name: "total_assessed_tax_amount"
      expr: SUM(CAST(assessed_tax_amount AS DOUBLE))
      comment: "Total assessed tax liability across all tax records. Primary KPI for tax obligation forecasting and budget planning."
    - name: "total_tax_paid_amount"
      expr: SUM(CAST(tax_paid_amount AS DOUBLE))
      comment: "Total taxes actually paid. Measures tax cash outflow and compliance with payment obligations."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred on tax records. Signals compliance failures and drives corrective action on filing processes."
    - name: "total_tax_abatement_amount"
      expr: SUM(CAST(tax_abatement_amount AS DOUBLE))
      comment: "Total tax abatements received. Measures tax savings from incentive programs and successful appeals."
    - name: "total_k1_ordinary_income_amount"
      expr: SUM(CAST(k1_ordinary_income_amount AS DOUBLE))
      comment: "Total K-1 ordinary income allocated to owners. Core investor tax reporting metric for partnership income distribution."
    - name: "total_k1_capital_gain_amount"
      expr: SUM(CAST(k1_capital_gain_amount AS DOUBLE))
      comment: "Total K-1 capital gains allocated to owners. Drives investor tax planning and 1031 exchange strategy decisions."
    - name: "total_k1_depreciation_amount"
      expr: SUM(CAST(k1_depreciation_amount AS DOUBLE))
      comment: "Total K-1 depreciation pass-through to owners. Key tax shelter metric for real estate investment tax efficiency analysis."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across all tax records. Benchmarks tax burden by jurisdiction and asset type."
    - name: "overdue_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'overdue' THEN tax_record_id END)
      comment: "Number of overdue tax filings. Critical compliance metric driving immediate remediation to avoid penalties and regulatory action."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charges accrued on tax obligations. Measures cost of late payment and drives cash flow prioritization for tax settlements."
$$;