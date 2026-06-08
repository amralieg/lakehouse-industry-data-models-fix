-- Metric views for domain: market | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core market access contract performance metrics tracking rebate commitments, contract value, and payer relationship economics"
  source: "`pharmaceuticals_ecm`.`market`.`market_payer_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the payer contract (active, expired, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of payer contract (rebate, value-based, formulary access)"
    - name: "payer_type"
      expr: CASE WHEN most_favored_nation_clause = TRUE THEN 'MFN Payer' ELSE 'Standard Payer' END
      comment: "Payer classification based on most favored nation clause presence"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier position negotiated in the contract"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "contract_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year the contract became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for contract financial terms"
    - name: "rebate_payment_frequency"
      expr: rebate_payment_frequency
      comment: "Frequency of rebate payments (monthly, quarterly, annual)"
    - name: "auto_renewal_flag"
      expr: CASE WHEN auto_renewal = TRUE THEN 'Auto-Renew' ELSE 'Manual Renewal' END
      comment: "Whether contract auto-renews or requires manual renewal"
    - name: "exclusivity_provision_flag"
      expr: CASE WHEN exclusivity_provision = TRUE THEN 'Exclusive' ELSE 'Non-Exclusive' END
      comment: "Whether contract includes exclusivity provisions"
  measures:
    - name: "total_estimated_annual_rebate"
      expr: SUM(CAST(estimated_annual_rebate_amount AS DOUBLE))
      comment: "Total estimated annual rebate commitment across all contracts"
    - name: "avg_base_rebate_rate"
      expr: AVG(CAST(base_rebate_pct AS DOUBLE))
      comment: "Average base rebate percentage across contracts"
    - name: "avg_incremental_rebate_rate"
      expr: AVG(CAST(incremental_rebate_pct AS DOUBLE))
      comment: "Average incremental rebate percentage for performance-based tiers"
    - name: "total_covered_lives"
      expr: SUM(CAST(book_of_business_lives AS DOUBLE))
      comment: "Total number of covered lives across all payer contracts"
    - name: "avg_covered_lives_per_contract"
      expr: AVG(CAST(book_of_business_lives AS DOUBLE))
      comment: "Average number of covered lives per contract"
    - name: "contract_count"
      expr: COUNT(DISTINCT market_payer_contract_id)
      comment: "Total number of unique payer contracts"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN market_payer_contract_id END)
      comment: "Number of currently active payer contracts"
    - name: "mfn_contract_count"
      expr: COUNT(DISTINCT CASE WHEN most_favored_nation_clause = TRUE THEN market_payer_contract_id END)
      comment: "Number of contracts with most favored nation clauses"
    - name: "price_protection_contract_count"
      expr: COUNT(DISTINCT CASE WHEN price_protection_clause = TRUE THEN market_payer_contract_id END)
      comment: "Number of contracts with price protection clauses"
    - name: "avg_admin_fee_rate"
      expr: AVG(CAST(admin_fee_pct AS DOUBLE))
      comment: "Average administrative fee percentage charged by payers"
    - name: "avg_performance_threshold"
      expr: AVG(CAST(performance_threshold_value AS DOUBLE))
      comment: "Average performance threshold value for incremental rebates"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_gross_to_net_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue realization metrics tracking gross-to-net adjustments, rebates, copay assistance, and channel economics"
  source: "`pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of gross-to-net adjustment (rebate, chargeback, copay, discount)"
    - name: "adjustment_subtype"
      expr: adjustment_subtype
      comment: "Detailed subtype of the adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (accrued, paid, disputed)"
    - name: "channel"
      expr: channel
      comment: "Distribution channel for the transaction"
    - name: "country_code"
      expr: country_code
      comment: "Country where the adjustment occurred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment amounts"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the adjustment"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the adjustment"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the adjustment period start"
    - name: "accrual_flag"
      expr: CASE WHEN accrual_flag = TRUE THEN 'Accrued' ELSE 'Actual' END
      comment: "Whether the adjustment is accrued or actual"
    - name: "dispute_flag"
      expr: CASE WHEN dispute_flag = TRUE THEN 'Disputed' ELSE 'Not Disputed' END
      comment: "Whether the adjustment is under dispute"
    - name: "medicaid_best_price_flag"
      expr: CASE WHEN medicaid_best_price_flag = TRUE THEN 'Medicaid Best Price' ELSE 'Non-Medicaid' END
      comment: "Whether adjustment impacts Medicaid best price calculation"
  measures:
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales before any adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total gross-to-net adjustment amount"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after all adjustments"
    - name: "total_copay_assistance"
      expr: SUM(CAST(copay_assistance_paid_amount AS DOUBLE))
      comment: "Total copay assistance paid to support patient access"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold across all transactions"
    - name: "avg_adjustment_rate"
      expr: AVG(CAST(adjustment_rate_pct AS DOUBLE))
      comment: "Average adjustment rate as percentage of gross sales"
    - name: "avg_gross_to_net_ratio"
      expr: AVG(CAST(net_revenue_amount AS DOUBLE) / NULLIF(CAST(gross_sales_amount AS DOUBLE), 0))
      comment: "Average ratio of net revenue to gross sales"
    - name: "avg_net_revenue_per_unit"
      expr: AVG(CAST(net_revenue_amount AS DOUBLE) / NULLIF(CAST(units_sold AS DOUBLE), 0))
      comment: "Average net revenue realized per unit sold"
    - name: "total_patient_liability"
      expr: SUM(CAST(patient_remaining_liability AS DOUBLE))
      comment: "Total remaining patient out-of-pocket liability after copay assistance"
    - name: "disputed_adjustment_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(adjustment_amount AS DOUBLE) ELSE 0 END)
      comment: "Total adjustment amount currently under dispute"
    - name: "transaction_count"
      expr: COUNT(DISTINCT gross_to_net_adjustment_id)
      comment: "Total number of gross-to-net adjustment transactions"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_rebate_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate claim processing and settlement metrics tracking claim volume, amounts, disputes, and payment performance"
  source: "`pharmaceuticals_ecm`.`market`.`rebate_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the rebate claim (submitted, approved, paid, disputed)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of rebate claim (standard, performance-based, value-based)"
    - name: "claim_direction"
      expr: claim_direction
      comment: "Direction of the claim (payable, receivable)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute on the claim"
    - name: "country_code"
      expr: country_code
      comment: "Country where the claim originated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the claim amounts"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the claimed product"
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier of the product at time of claim"
    - name: "rebate_tier"
      expr: rebate_tier
      comment: "Rebate tier applied to the claim"
    - name: "claim_quarter"
      expr: CONCAT('Q', QUARTER(claim_period_start_date), '-', YEAR(claim_period_start_date))
      comment: "Quarter of the claim period start"
    - name: "claim_year"
      expr: YEAR(claim_period_start_date)
      comment: "Year of the claim period start"
    - name: "medicaid_rebate_flag"
      expr: CASE WHEN medicaid_rebate_flag = TRUE THEN 'Medicaid' ELSE 'Commercial' END
      comment: "Whether claim is for Medicaid rebate"
    - name: "prior_period_adjustment_flag"
      expr: CASE WHEN prior_period_adjustment_flag = TRUE THEN 'Prior Period Adjustment' ELSE 'Current Period' END
      comment: "Whether claim is a prior period adjustment"
  measures:
    - name: "total_gross_rebate"
      expr: SUM(CAST(gross_rebate_amount AS DOUBLE))
      comment: "Total gross rebate amount before adjustments"
    - name: "total_net_rebate"
      expr: SUM(CAST(net_rebate_amount AS DOUBLE))
      comment: "Total net rebate amount after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to rebate claims"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount currently under dispute"
    - name: "total_eligible_units"
      expr: SUM(CAST(eligible_units AS DOUBLE))
      comment: "Total units eligible for rebate"
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate percentage across claims"
    - name: "avg_wac_price"
      expr: AVG(CAST(wac_price AS DOUBLE))
      comment: "Average wholesale acquisition cost price"
    - name: "avg_market_share"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage across claims"
    - name: "avg_rebate_per_unit"
      expr: AVG(CAST(net_rebate_amount AS DOUBLE) / NULLIF(CAST(eligible_units AS DOUBLE), 0))
      comment: "Average net rebate amount per eligible unit"
    - name: "claim_count"
      expr: COUNT(DISTINCT rebate_claim_id)
      comment: "Total number of rebate claims"
    - name: "disputed_claim_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'Resolved' THEN rebate_claim_id END)
      comment: "Number of claims currently in dispute"
    - name: "paid_claim_count"
      expr: COUNT(DISTINCT CASE WHEN claim_status = 'Paid' THEN rebate_claim_id END)
      comment: "Number of claims that have been paid"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_payer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer account portfolio metrics tracking covered lives, formulary influence, and strategic payer relationships"
  source: "`pharmaceuticals_ecm`.`market`.`payer_account`"
  dimensions:
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer organization (commercial, government, managed care)"
    - name: "payer_subtype"
      expr: payer_subtype
      comment: "Detailed subtype of payer"
    - name: "account_status"
      expr: account_status
      comment: "Current status of the payer account"
    - name: "tier"
      expr: tier
      comment: "Strategic tier classification of the payer"
    - name: "hq_country_code"
      expr: hq_country_code
      comment: "Country code of payer headquarters"
    - name: "geographic_coverage_scope"
      expr: geographic_coverage_scope
      comment: "Geographic scope of payer coverage (national, regional, local)"
    - name: "pbm_affiliation"
      expr: pbm_affiliation
      comment: "Pharmacy benefit manager affiliation"
    - name: "formulary_tier_position"
      expr: formulary_tier_position
      comment: "Current formulary tier position for key products"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract in place with payer"
    - name: "value_based_contract_eligible_flag"
      expr: CASE WHEN value_based_contract_eligible = TRUE THEN 'VBC Eligible' ELSE 'Not VBC Eligible' END
      comment: "Whether payer is eligible for value-based contracts"
    - name: "prior_authorization_required_flag"
      expr: CASE WHEN prior_authorization_required = TRUE THEN 'PA Required' ELSE 'No PA' END
      comment: "Whether payer requires prior authorization"
    - name: "copay_assistance_accepted_flag"
      expr: CASE WHEN copay_assistance_accepted = TRUE THEN 'Accepts Copay' ELSE 'No Copay' END
      comment: "Whether payer accepts copay assistance programs"
  measures:
    - name: "total_covered_lives"
      expr: SUM(CAST(covered_lives AS DOUBLE))
      comment: "Total number of lives covered across all payer accounts"
    - name: "avg_covered_lives_per_payer"
      expr: AVG(CAST(covered_lives AS DOUBLE))
      comment: "Average number of covered lives per payer account"
    - name: "avg_formulary_influence_score"
      expr: AVG(CAST(formulary_influence_score AS DOUBLE))
      comment: "Average formulary influence score across payers"
    - name: "payer_account_count"
      expr: COUNT(DISTINCT payer_account_id)
      comment: "Total number of unique payer accounts"
    - name: "active_payer_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN payer_account_id END)
      comment: "Number of active payer accounts"
    - name: "vbc_eligible_payer_count"
      expr: COUNT(DISTINCT CASE WHEN value_based_contract_eligible = TRUE THEN payer_account_id END)
      comment: "Number of payers eligible for value-based contracts"
    - name: "copay_accepting_payer_count"
      expr: COUNT(DISTINCT CASE WHEN copay_assistance_accepted = TRUE THEN payer_account_id END)
      comment: "Number of payers accepting copay assistance"
    - name: "rwe_data_sharing_payer_count"
      expr: COUNT(DISTINCT CASE WHEN rwe_data_sharing_agreement = TRUE THEN payer_account_id END)
      comment: "Number of payers with real-world evidence data sharing agreements"
    - name: "contracting_authority_payer_count"
      expr: COUNT(DISTINCT CASE WHEN contracting_authority = TRUE THEN payer_account_id END)
      comment: "Number of payers with contracting authority"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_hta_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health technology assessment submission performance metrics tracking approval rates, ICER values, and reimbursement outcomes"
  source: "`pharmaceuticals_ecm`.`market`.`hta_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the HTA submission"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of HTA submission (initial, resubmission, appeal)"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of decision received from HTA body"
    - name: "hta_body_code"
      expr: hta_body_code
      comment: "Code identifying the HTA body"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the submitted product"
    - name: "benefit_rating"
      expr: benefit_rating
      comment: "Benefit rating assigned by HTA body"
    - name: "economic_model_type"
      expr: economic_model_type
      comment: "Type of economic model used in submission"
    - name: "evidence_package_type"
      expr: evidence_package_type
      comment: "Type of evidence package submitted"
    - name: "submission_year"
      expr: YEAR(actual_submission_date)
      comment: "Year of actual submission"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(actual_submission_date), '-', YEAR(actual_submission_date))
      comment: "Quarter of actual submission"
    - name: "appeal_filed_flag"
      expr: CASE WHEN appeal_filed = TRUE THEN 'Appeal Filed' ELSE 'No Appeal' END
      comment: "Whether an appeal was filed"
    - name: "managed_access_scheme_flag"
      expr: CASE WHEN managed_access_scheme = TRUE THEN 'Managed Access' ELSE 'Standard Access' END
      comment: "Whether submission includes managed access scheme"
    - name: "rwe_required_flag"
      expr: CASE WHEN rwe_required = TRUE THEN 'RWE Required' ELSE 'No RWE' END
      comment: "Whether real-world evidence is required"
  measures:
    - name: "avg_icer_submitted"
      expr: AVG(CAST(icer_submitted AS DOUBLE))
      comment: "Average incremental cost-effectiveness ratio submitted"
    - name: "avg_willingness_to_pay_threshold"
      expr: AVG(CAST(willingness_to_pay_threshold AS DOUBLE))
      comment: "Average willingness-to-pay threshold for the jurisdiction"
    - name: "avg_recommended_price_lower"
      expr: AVG(CAST(recommended_price_lower AS DOUBLE))
      comment: "Average lower bound of recommended price range"
    - name: "avg_recommended_price_upper"
      expr: AVG(CAST(recommended_price_upper AS DOUBLE))
      comment: "Average upper bound of recommended price range"
    - name: "submission_count"
      expr: COUNT(DISTINCT hta_submission_id)
      comment: "Total number of HTA submissions"
    - name: "approved_submission_count"
      expr: COUNT(DISTINCT CASE WHEN decision_type IN ('Approved', 'Positive') THEN hta_submission_id END)
      comment: "Number of approved HTA submissions"
    - name: "appeal_filed_count"
      expr: COUNT(DISTINCT CASE WHEN appeal_filed = TRUE THEN hta_submission_id END)
      comment: "Number of submissions with appeals filed"
    - name: "managed_access_count"
      expr: COUNT(DISTINCT CASE WHEN managed_access_scheme = TRUE THEN hta_submission_id END)
      comment: "Number of submissions with managed access schemes"
    - name: "rwe_required_count"
      expr: COUNT(DISTINCT CASE WHEN rwe_required = TRUE THEN hta_submission_id END)
      comment: "Number of submissions requiring real-world evidence"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_patient_access_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient access program performance metrics tracking program reach, budget utilization, and patient support effectiveness"
  source: "`pharmaceuticals_ecm`.`market`.`patient_access_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the patient access program"
    - name: "program_type"
      expr: program_type
      comment: "Type of patient access program (copay, free drug, bridge)"
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit provided to patients"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the program"
    - name: "payer_segment"
      expr: payer_segment
      comment: "Target payer segment for the program"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of program funding"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which patients enroll"
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy targeted by the program"
    - name: "program_year"
      expr: YEAR(effective_start_date)
      comment: "Year the program became effective"
    - name: "income_threshold_required_flag"
      expr: CASE WHEN income_threshold_required = TRUE THEN 'Income Threshold' ELSE 'No Income Threshold' END
      comment: "Whether program requires income threshold verification"
    - name: "rems_program_flag"
      expr: CASE WHEN rems_program_flag = TRUE THEN 'REMS Program' ELSE 'Non-REMS' END
      comment: "Whether program is part of REMS requirements"
    - name: "specialty_pharmacy_required_flag"
      expr: CASE WHEN specialty_pharmacy_required = TRUE THEN 'Specialty Pharmacy' ELSE 'Standard Pharmacy' END
      comment: "Whether program requires specialty pharmacy"
  measures:
    - name: "total_program_budget"
      expr: SUM(CAST(annual_program_budget AS DOUBLE))
      comment: "Total annual budget allocated across all patient access programs"
    - name: "avg_program_budget"
      expr: AVG(CAST(annual_program_budget AS DOUBLE))
      comment: "Average annual budget per patient access program"
    - name: "avg_benefit_cap"
      expr: AVG(CAST(benefit_cap_amount AS DOUBLE))
      comment: "Average benefit cap amount per patient"
    - name: "program_count"
      expr: COUNT(DISTINCT patient_access_program_id)
      comment: "Total number of patient access programs"
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN patient_access_program_id END)
      comment: "Number of currently active patient access programs"
    - name: "rems_program_count"
      expr: COUNT(DISTINCT CASE WHEN rems_program_flag = TRUE THEN patient_access_program_id END)
      comment: "Number of programs that are part of REMS requirements"
    - name: "income_threshold_program_count"
      expr: COUNT(DISTINCT CASE WHEN income_threshold_required = TRUE THEN patient_access_program_id END)
      comment: "Number of programs requiring income threshold verification"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_pricing_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing strategy and decision metrics tracking list prices, net prices, gross-to-net erosion, and international reference pricing"
  source: "`pharmaceuticals_ecm`.`market`.`pricing_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the pricing decision"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of pricing decision (launch, increase, decrease, maintain)"
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel for the pricing decision"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the product"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing decision"
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Reimbursement status at time of pricing decision"
    - name: "launch_sequence_priority"
      expr: launch_sequence_priority
      comment: "Priority in the launch sequence across markets"
    - name: "decision_year"
      expr: YEAR(effective_date)
      comment: "Year the pricing decision became effective"
    - name: "decision_quarter"
      expr: CONCAT('Q', QUARTER(effective_date), '-', YEAR(effective_date))
      comment: "Quarter the pricing decision became effective"
    - name: "irp_constraint_flag"
      expr: CASE WHEN irp_constraint_flag = TRUE THEN 'IRP Constrained' ELSE 'No IRP Constraint' END
      comment: "Whether decision is constrained by international reference pricing"
  measures:
    - name: "avg_list_price_wac"
      expr: AVG(CAST(list_price_wac AS DOUBLE))
      comment: "Average wholesale acquisition cost list price"
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price after discounts and rebates"
    - name: "avg_target_price"
      expr: AVG(CAST(target_price AS DOUBLE))
      comment: "Average target price for the market"
    - name: "avg_gross_to_net_pct"
      expr: AVG(CAST(gross_to_net_pct AS DOUBLE))
      comment: "Average gross-to-net percentage erosion"
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average percentage price change from prior decision"
    - name: "avg_ceiling_price"
      expr: AVG(CAST(ceiling_price AS DOUBLE))
      comment: "Average ceiling price constraint"
    - name: "avg_floor_price"
      expr: AVG(CAST(floor_price AS DOUBLE))
      comment: "Average floor price constraint"
    - name: "avg_government_reference_price"
      expr: AVG(CAST(government_reference_price AS DOUBLE))
      comment: "Average government reference price"
    - name: "avg_irp_reference_price"
      expr: AVG(CAST(irp_reference_price AS DOUBLE))
      comment: "Average international reference price"
    - name: "avg_corridor_breach_threshold"
      expr: AVG(CAST(corridor_breach_threshold_pct AS DOUBLE))
      comment: "Average corridor breach threshold percentage"
    - name: "pricing_decision_count"
      expr: COUNT(DISTINCT pricing_decision_id)
      comment: "Total number of pricing decisions"
    - name: "irp_constrained_decision_count"
      expr: COUNT(DISTINCT CASE WHEN irp_constraint_flag = TRUE THEN pricing_decision_id END)
      comment: "Number of pricing decisions constrained by international reference pricing"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_outcomes_based_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outcomes-based and value-based contract performance metrics tracking outcome achievement, rebate adjustments, and real-world evidence utilization"
  source: "`pharmaceuticals_ecm`.`market`.`outcomes_based_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the outcomes-based contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of outcomes-based contract (pay-for-performance, risk-sharing, outcomes guarantee)"
    - name: "outcome_metric_type"
      expr: outcome_metric_type
      comment: "Type of outcome metric being measured"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the contract"
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of threshold (above or below target triggers rebate)"
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source used for outcome measurement"
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Frequency of outcome reconciliation and rebate adjustment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of contract financial terms"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "measurement_period_year"
      expr: YEAR(measurement_period_start_date)
      comment: "Year of the outcome measurement period"
    - name: "data_sharing_agreement_flag"
      expr: CASE WHEN data_sharing_agreement_flag = TRUE THEN 'Data Sharing' ELSE 'No Data Sharing' END
      comment: "Whether contract includes data sharing agreement"
    - name: "most_favored_nation_clause_flag"
      expr: CASE WHEN most_favored_nation_clause = TRUE THEN 'MFN Clause' ELSE 'No MFN' END
      comment: "Whether contract includes most favored nation clause"
  measures:
    - name: "avg_base_rebate_pct"
      expr: AVG(CAST(base_rebate_pct AS DOUBLE))
      comment: "Average base rebate percentage before outcome adjustment"
    - name: "avg_max_rebate_pct"
      expr: AVG(CAST(max_rebate_pct AS DOUBLE))
      comment: "Average maximum rebate percentage if outcomes not met"
    - name: "avg_performance_threshold"
      expr: AVG(CAST(performance_threshold_value AS DOUBLE))
      comment: "Average performance threshold value for outcome metric"
    - name: "avg_observed_outcome_rate"
      expr: AVG(CAST(observed_outcome_rate AS DOUBLE))
      comment: "Average observed outcome rate from real-world data"
    - name: "avg_variance_from_threshold"
      expr: AVG(CAST(variance_from_threshold AS DOUBLE))
      comment: "Average variance of observed outcome from threshold"
    - name: "total_rebate_adjustment"
      expr: SUM(CAST(rebate_adjustment_amount AS DOUBLE))
      comment: "Total rebate adjustment amount based on outcomes"
    - name: "avg_rebate_adjustment_pct"
      expr: AVG(CAST(rebate_adjustment_pct AS DOUBLE))
      comment: "Average rebate adjustment percentage based on outcomes"
    - name: "contract_count"
      expr: COUNT(DISTINCT outcomes_based_contract_id)
      comment: "Total number of outcomes-based contracts"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN outcomes_based_contract_id END)
      comment: "Number of currently active outcomes-based contracts"
    - name: "data_sharing_contract_count"
      expr: COUNT(DISTINCT CASE WHEN data_sharing_agreement_flag = TRUE THEN outcomes_based_contract_id END)
      comment: "Number of contracts with data sharing agreements"
    - name: "mfn_contract_count"
      expr: COUNT(DISTINCT CASE WHEN most_favored_nation_clause = TRUE THEN outcomes_based_contract_id END)
      comment: "Number of contracts with most favored nation clauses"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_coverage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payer coverage decision metrics tracking formulary access, utilization management requirements, and covered lives impact"
  source: "`pharmaceuticals_ecm`.`market`.`coverage_decision`"
  dimensions:
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the coverage decision"
    - name: "decision_type"
      expr: decision_type
      comment: "Type of coverage decision (add, remove, restrict, expand)"
    - name: "coverage_restriction_type"
      expr: coverage_restriction_type
      comment: "Type of coverage restriction applied"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the covered product"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer making the coverage decision"
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy covered by the decision"
    - name: "reimbursement_scope"
      expr: reimbursement_scope
      comment: "Scope of reimbursement coverage"
    - name: "decision_year"
      expr: YEAR(decision_date)
      comment: "Year of the coverage decision"
    - name: "decision_quarter"
      expr: CONCAT('Q', QUARTER(decision_date), '-', YEAR(decision_date))
      comment: "Quarter of the coverage decision"
    - name: "prior_authorization_required_flag"
      expr: CASE WHEN prior_authorization_required = TRUE THEN 'PA Required' ELSE 'No PA' END
      comment: "Whether prior authorization is required"
    - name: "step_therapy_required_flag"
      expr: CASE WHEN step_therapy_required = TRUE THEN 'Step Therapy' ELSE 'No Step Therapy' END
      comment: "Whether step therapy is required"
    - name: "quantity_limit_flag"
      expr: CASE WHEN quantity_limit_flag = TRUE THEN 'Quantity Limit' ELSE 'No Quantity Limit' END
      comment: "Whether quantity limits are applied"
    - name: "managed_entry_agreement_flag"
      expr: CASE WHEN managed_entry_agreement_flag = TRUE THEN 'Managed Entry' ELSE 'Standard Entry' END
      comment: "Whether decision includes managed entry agreement"
    - name: "rwe_required_flag"
      expr: CASE WHEN rwe_required_flag = TRUE THEN 'RWE Required' ELSE 'No RWE' END
      comment: "Whether real-world evidence is required"
  measures:
    - name: "total_lives_covered"
      expr: SUM(CAST(lives_covered AS DOUBLE))
      comment: "Total number of lives covered by coverage decisions"
    - name: "avg_lives_covered_per_decision"
      expr: AVG(CAST(lives_covered AS DOUBLE))
      comment: "Average number of lives covered per coverage decision"
    - name: "coverage_decision_count"
      expr: COUNT(DISTINCT coverage_decision_id)
      comment: "Total number of coverage decisions"
    - name: "positive_decision_count"
      expr: COUNT(DISTINCT CASE WHEN decision_status IN ('Approved', 'Covered') THEN coverage_decision_id END)
      comment: "Number of positive coverage decisions"
    - name: "prior_auth_required_count"
      expr: COUNT(DISTINCT CASE WHEN prior_authorization_required = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions requiring prior authorization"
    - name: "step_therapy_required_count"
      expr: COUNT(DISTINCT CASE WHEN step_therapy_required = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions requiring step therapy"
    - name: "quantity_limit_count"
      expr: COUNT(DISTINCT CASE WHEN quantity_limit_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions with quantity limits"
    - name: "managed_entry_count"
      expr: COUNT(DISTINCT CASE WHEN managed_entry_agreement_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions with managed entry agreements"
    - name: "rwe_required_count"
      expr: COUNT(DISTINCT CASE WHEN rwe_required_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions requiring real-world evidence"
    - name: "patient_access_program_count"
      expr: COUNT(DISTINCT CASE WHEN patient_access_program_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of decisions linked to patient access programs"
$$;