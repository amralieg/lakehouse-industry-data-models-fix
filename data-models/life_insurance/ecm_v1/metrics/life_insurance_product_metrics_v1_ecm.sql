-- Metric views for domain: product | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core product plan performance metrics including face amount coverage, policy counts, and profitability targets"
  source: "`life_insurance_ecm`.`product`.`plan`"
  dimensions:
    - name: "plan_code"
      expr: plan_code
      comment: "Unique identifier code for the insurance plan"
    - name: "plan_name"
      expr: plan_name
      comment: "Business name of the insurance plan"
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (active, retired, etc.)"
    - name: "insurance_type"
      expr: insurance_type
      comment: "Type of insurance product (term, whole life, universal life, etc.)"
    - name: "product_family"
      expr: product_family
      comment: "Product family grouping for portfolio analysis"
    - name: "distribution_channel"
      expr: distribution_channel_availability
      comment: "Sales channels where this plan is available"
    - name: "tax_qualification_status"
      expr: tax_qualification_status
      comment: "Tax qualification status (qualified, non-qualified, etc.)"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant
      comment: "Whether plan meets IRC Section 7702 life insurance definition requirements"
    - name: "participating_product_flag"
      expr: participating_product
      comment: "Whether plan pays dividends to policyholders"
    - name: "plan_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective"
  measures:
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Total number of insurance plans"
    - name: "total_maximum_face_amount"
      expr: SUM(CAST(maximum_face_amount AS DOUBLE))
      comment: "Total maximum face amount capacity across all plans"
    - name: "avg_maximum_face_amount"
      expr: AVG(CAST(maximum_face_amount AS DOUBLE))
      comment: "Average maximum face amount per plan"
    - name: "avg_minimum_face_amount"
      expr: AVG(CAST(minimum_face_amount AS DOUBLE))
      comment: "Average minimum face amount per plan"
    - name: "avg_profitability_target_irr_pct"
      expr: AVG(CAST(profitability_target_irr AS DOUBLE))
      comment: "Average target internal rate of return across plans"
    - name: "avg_gpt_corridor_factor"
      expr: AVG(CAST(gpt_corridor_factor AS DOUBLE))
      comment: "Average guideline premium test corridor factor for IRC 7702 compliance"
    - name: "irc_compliant_plan_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN 1 END)
      comment: "Count of plans compliant with IRC Section 7702"
    - name: "participating_plan_count"
      expr: COUNT(CASE WHEN participating_product = TRUE THEN 1 END)
      comment: "Count of participating (dividend-paying) plans"
    - name: "guaranteed_issue_plan_count"
      expr: COUNT(CASE WHEN guaranteed_issue = TRUE THEN 1 END)
      comment: "Count of plans offering guaranteed issue without medical underwriting"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_plan_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan version lifecycle and profitability metrics tracking version changes, approvals, and closed block transitions"
  source: "`life_insurance_ecm`.`product`.`plan_version`"
  dimensions:
    - name: "version_number"
      expr: version_number
      comment: "Version identifier for the plan iteration"
    - name: "version_status"
      expr: version_status
      comment: "Current status of the plan version (active, pending, retired, etc.)"
    - name: "version_type"
      expr: version_type
      comment: "Type of version change (major, minor, regulatory, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan version"
    - name: "closed_block_indicator"
      expr: closed_block_indicator
      comment: "Whether this version is part of a closed block"
    - name: "gpt_compliant_flag"
      expr: gpt_compliant
      comment: "Guideline premium test compliance flag"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant
      comment: "IRC Section 7702 compliance flag"
    - name: "mec_risk_indicator"
      expr: mec_risk_indicator
      comment: "Modified endowment contract risk indicator"
    - name: "pbr_applicable_flag"
      expr: pbr_applicable
      comment: "Whether principle-based reserving applies to this version"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan version became effective"
  measures:
    - name: "plan_version_count"
      expr: COUNT(1)
      comment: "Total number of plan versions"
    - name: "avg_expected_nbv_per_policy"
      expr: AVG(CAST(expected_nbv_per_policy AS DOUBLE))
      comment: "Average expected new business value per policy across versions"
    - name: "total_expected_nbv"
      expr: SUM(CAST(expected_nbv_per_policy AS DOUBLE))
      comment: "Total expected new business value across all plan versions"
    - name: "avg_profitability_target_irr_pct"
      expr: AVG(CAST(profitability_target_irr AS DOUBLE))
      comment: "Average target internal rate of return for plan versions"
    - name: "avg_maximum_face_amount"
      expr: AVG(CAST(maximum_face_amount AS DOUBLE))
      comment: "Average maximum face amount across plan versions"
    - name: "avg_minimum_face_amount"
      expr: AVG(CAST(minimum_face_amount AS DOUBLE))
      comment: "Average minimum face amount across plan versions"
    - name: "closed_block_version_count"
      expr: COUNT(CASE WHEN closed_block_indicator = TRUE THEN 1 END)
      comment: "Count of plan versions in closed block status"
    - name: "pbr_applicable_version_count"
      expr: COUNT(CASE WHEN pbr_applicable = TRUE THEN 1 END)
      comment: "Count of versions subject to principle-based reserving"
    - name: "mec_risk_version_count"
      expr: COUNT(CASE WHEN mec_risk_indicator = TRUE THEN 1 END)
      comment: "Count of versions with modified endowment contract risk"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory filing performance metrics tracking approval rates, review durations, and compliance status"
  source: "`life_insurance_ecm`.`product`.`filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (rate, form, product, etc.)"
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing (pending, approved, rejected, etc.)"
    - name: "filing_method"
      expr: filing_method
      comment: "Method used for filing submission"
    - name: "primary_jurisdiction_state"
      expr: primary_jurisdiction_state
      comment: "Primary state jurisdiction for the filing"
    - name: "priority"
      expr: priority
      comment: "Priority level of the filing"
    - name: "sec_registration_required_flag"
      expr: sec_registration_required
      comment: "Whether SEC registration is required for this filing"
    - name: "irc_7702_compliance_certified_flag"
      expr: irc_7702_compliance_certification
      comment: "Whether IRC 7702 compliance has been certified"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the filing was submitted"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the filing was approved"
  measures:
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total number of regulatory filings"
    - name: "approved_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'approved' THEN 1 END)
      comment: "Count of approved filings"
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'rejected' THEN 1 END)
      comment: "Count of rejected filings"
    - name: "pending_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'pending' THEN 1 END)
      comment: "Count of filings currently pending review"
    - name: "total_filing_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total regulatory filing fees paid"
    - name: "avg_filing_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average filing fee per submission"
    - name: "sec_registration_filing_count"
      expr: COUNT(CASE WHEN sec_registration_required = TRUE THEN 1 END)
      comment: "Count of filings requiring SEC registration"
    - name: "irc_certified_filing_count"
      expr: COUNT(CASE WHEN irc_7702_compliance_certification = TRUE THEN 1 END)
      comment: "Count of filings with IRC 7702 compliance certification"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_state_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "State-by-state product approval metrics tracking approval rates, face amount limits, and regulatory compliance by jurisdiction"
  source: "`life_insurance_ecm`.`product`.`state_approval`"
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction code"
    - name: "filing_status"
      expr: filing_status
      comment: "Current filing status in the state"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of state filing"
    - name: "sec_filing_required_flag"
      expr: sec_filing_required
      comment: "Whether SEC filing is required in this state"
    - name: "finra_review_required_flag"
      expr: finra_review_required
      comment: "Whether FINRA review is required"
    - name: "irc_7702_compliance_confirmed_flag"
      expr: irc_7702_compliance_confirmed
      comment: "Whether IRC 7702 compliance has been confirmed for this state"
    - name: "replacement_regulations_apply_flag"
      expr: replacement_regulations_apply
      comment: "Whether state replacement regulations apply"
    - name: "policy_loan_provisions_approved_flag"
      expr: policy_loan_provisions_approved
      comment: "Whether policy loan provisions have been approved"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of state approval"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of state filing"
  measures:
    - name: "state_approval_count"
      expr: COUNT(1)
      comment: "Total number of state approvals"
    - name: "approved_state_count"
      expr: COUNT(CASE WHEN filing_status = 'approved' THEN 1 END)
      comment: "Count of states where product is approved"
    - name: "pending_state_count"
      expr: COUNT(CASE WHEN filing_status = 'pending' THEN 1 END)
      comment: "Count of states with pending approval"
    - name: "total_maximum_face_amount"
      expr: SUM(CAST(maximum_face_amount AS DOUBLE))
      comment: "Total maximum face amount approved across all states"
    - name: "avg_maximum_face_amount"
      expr: AVG(CAST(maximum_face_amount AS DOUBLE))
      comment: "Average maximum face amount per state approval"
    - name: "total_minimum_face_amount"
      expr: SUM(CAST(minimum_face_amount AS DOUBLE))
      comment: "Total minimum face amount across all state approvals"
    - name: "avg_minimum_face_amount"
      expr: AVG(CAST(minimum_face_amount AS DOUBLE))
      comment: "Average minimum face amount per state approval"
    - name: "sec_filing_required_count"
      expr: COUNT(CASE WHEN sec_filing_required = TRUE THEN 1 END)
      comment: "Count of state approvals requiring SEC filing"
    - name: "finra_review_required_count"
      expr: COUNT(CASE WHEN finra_review_required = TRUE THEN 1 END)
      comment: "Count of state approvals requiring FINRA review"
    - name: "irc_compliant_state_count"
      expr: COUNT(CASE WHEN irc_7702_compliance_confirmed = TRUE THEN 1 END)
      comment: "Count of states with confirmed IRC 7702 compliance"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_premium_rate_table`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate table metrics analyzing rate structures, mortality factors, and pricing by underwriting class and demographics"
  source: "`life_insurance_ecm`.`product`.`premium_rate_table`"
  dimensions:
    - name: "rate_table_code"
      expr: rate_table_code
      comment: "Unique code identifying the rate table"
    - name: "rate_table_name"
      expr: rate_table_name
      comment: "Business name of the rate table"
    - name: "rate_table_status"
      expr: rate_table_status
      comment: "Current status of the rate table"
    - name: "rate_type"
      expr: rate_type
      comment: "Type of rate (premium, COI, etc.)"
    - name: "rate_schedule_type"
      expr: rate_schedule_type
      comment: "Schedule type for rate application"
    - name: "gender"
      expr: gender
      comment: "Gender classification for rate differentiation"
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use status for rate classification"
    - name: "mortality_table_basis"
      expr: mortality_table_basis
      comment: "Mortality table used as basis for rates"
    - name: "payment_mode"
      expr: payment_mode
      comment: "Premium payment frequency mode"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for the rate table"
    - name: "guaranteed_flag"
      expr: guaranteed_flag
      comment: "Whether rates are guaranteed"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "IRC Section 7702 compliance flag"
    - name: "rate_effective_year"
      expr: YEAR(rate_effective_date)
      comment: "Year the rate became effective"
  measures:
    - name: "rate_table_count"
      expr: COUNT(1)
      comment: "Total number of premium rate table entries"
    - name: "avg_rate_per_unit"
      expr: AVG(CAST(rate_per_unit AS DOUBLE))
      comment: "Average premium rate per unit of coverage"
    - name: "avg_coi_rate_per_thousand"
      expr: AVG(CAST(coi_rate_per_thousand AS DOUBLE))
      comment: "Average cost of insurance rate per thousand dollars of coverage"
    - name: "avg_modal_factor"
      expr: AVG(CAST(modal_factor AS DOUBLE))
      comment: "Average modal factor for payment frequency adjustment"
    - name: "avg_table_rating_factor"
      expr: AVG(CAST(table_rating_factor AS DOUBLE))
      comment: "Average table rating factor for substandard risk adjustment"
    - name: "avg_flat_extra_amount"
      expr: AVG(CAST(flat_extra_amount AS DOUBLE))
      comment: "Average flat extra premium amount for substandard risks"
    - name: "total_flat_extra_amount"
      expr: SUM(CAST(flat_extra_amount AS DOUBLE))
      comment: "Total flat extra premium amounts across all rate entries"
    - name: "avg_face_amount_band_min"
      expr: AVG(CAST(face_amount_band_min AS DOUBLE))
      comment: "Average minimum face amount for rate band"
    - name: "avg_face_amount_band_max"
      expr: AVG(CAST(face_amount_band_max AS DOUBLE))
      comment: "Average maximum face amount for rate band"
    - name: "guaranteed_rate_count"
      expr: COUNT(CASE WHEN guaranteed_flag = TRUE THEN 1 END)
      comment: "Count of guaranteed rate entries"
    - name: "irc_compliant_rate_count"
      expr: COUNT(CASE WHEN irc_7702_compliant_flag = TRUE THEN 1 END)
      comment: "Count of IRC 7702 compliant rate entries"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_rider_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rider product metrics tracking benefit structures, pricing, and availability of supplemental insurance riders"
  source: "`life_insurance_ecm`.`product`.`rider_definition`"
  dimensions:
    - name: "rider_code"
      expr: rider_code
      comment: "Unique code identifying the rider"
    - name: "rider_name"
      expr: rider_name
      comment: "Business name of the rider"
    - name: "rider_type"
      expr: rider_type
      comment: "Type classification of the rider"
    - name: "rider_category"
      expr: rider_category
      comment: "Category grouping for the rider"
    - name: "rider_definition_status"
      expr: rider_definition_status
      comment: "Current status of the rider definition"
    - name: "accelerated_benefit_flag"
      expr: accelerated_benefit_flag
      comment: "Whether rider provides accelerated death benefit"
    - name: "guaranteed_insurability_flag"
      expr: guaranteed_insurability_flag
      comment: "Whether rider includes guaranteed insurability option"
    - name: "waiver_of_premium_flag"
      expr: waiver_of_premium_flag
      comment: "Whether rider includes waiver of premium benefit"
    - name: "return_of_premium_flag"
      expr: return_of_premium_flag
      comment: "Whether rider includes return of premium feature"
    - name: "ltc_qualified_flag"
      expr: ltc_qualified_flag
      comment: "Whether rider is qualified for long-term care tax benefits"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant
      comment: "IRC Section 7702 compliance flag"
    - name: "medical_evidence_required_flag"
      expr: medical_evidence_required
      comment: "Whether medical evidence is required for rider"
    - name: "illustration_required_flag"
      expr: illustration_required
      comment: "Whether illustration is required for rider sales"
    - name: "premium_basis"
      expr: premium_basis
      comment: "Basis for calculating rider premium"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rider became effective"
  measures:
    - name: "rider_count"
      expr: COUNT(1)
      comment: "Total number of rider definitions"
    - name: "avg_maximum_benefit_amount"
      expr: AVG(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount across riders"
    - name: "total_maximum_benefit_amount"
      expr: SUM(CAST(maximum_benefit_amount AS DOUBLE))
      comment: "Total maximum benefit amount capacity across all riders"
    - name: "avg_minimum_benefit_amount"
      expr: AVG(CAST(minimum_benefit_amount AS DOUBLE))
      comment: "Average minimum benefit amount across riders"
    - name: "accelerated_benefit_rider_count"
      expr: COUNT(CASE WHEN accelerated_benefit_flag = TRUE THEN 1 END)
      comment: "Count of riders offering accelerated death benefits"
    - name: "guaranteed_insurability_rider_count"
      expr: COUNT(CASE WHEN guaranteed_insurability_flag = TRUE THEN 1 END)
      comment: "Count of riders with guaranteed insurability option"
    - name: "waiver_of_premium_rider_count"
      expr: COUNT(CASE WHEN waiver_of_premium_flag = TRUE THEN 1 END)
      comment: "Count of riders with waiver of premium benefit"
    - name: "ltc_qualified_rider_count"
      expr: COUNT(CASE WHEN ltc_qualified_flag = TRUE THEN 1 END)
      comment: "Count of long-term care qualified riders"
    - name: "irc_compliant_rider_count"
      expr: COUNT(CASE WHEN irc_7702_compliant = TRUE THEN 1 END)
      comment: "Count of IRC 7702 compliant riders"
    - name: "medical_evidence_required_rider_count"
      expr: COUNT(CASE WHEN medical_evidence_required = TRUE THEN 1 END)
      comment: "Count of riders requiring medical evidence"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_profitability_assumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product profitability assumption metrics tracking pricing assumptions, target returns, and expense loadings for actuarial modeling"
  source: "`life_insurance_ecm`.`product`.`profitability_assumption`"
  dimensions:
    - name: "assumption_set_code"
      expr: assumption_set_code
      comment: "Unique code for the assumption set"
    - name: "assumption_set_name"
      expr: assumption_set_name
      comment: "Business name of the assumption set"
    - name: "assumption_status"
      expr: assumption_status
      comment: "Current status of the assumption set"
    - name: "assumption_category"
      expr: assumption_category
      comment: "Category classification of assumptions"
    - name: "pricing_actuary_name"
      expr: pricing_actuary_name
      comment: "Name of the pricing actuary responsible for assumptions"
    - name: "pricing_mortality_table"
      expr: pricing_mortality_table
      comment: "Mortality table used for pricing"
    - name: "dac_amortization_basis"
      expr: dac_amortization_basis
      comment: "Basis for deferred acquisition cost amortization"
    - name: "approved_by_role"
      expr: approved_by_role
      comment: "Role that approved the assumption set"
    - name: "peer_review_completed_flag"
      expr: peer_review_completed_flag
      comment: "Whether peer review has been completed"
    - name: "sensitivity_test_performed_flag"
      expr: sensitivity_test_performed_flag
      comment: "Whether sensitivity testing has been performed"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the assumptions became effective"
  measures:
    - name: "assumption_set_count"
      expr: COUNT(1)
      comment: "Total number of profitability assumption sets"
    - name: "avg_target_irr_pct"
      expr: AVG(CAST(target_irr_percent AS DOUBLE))
      comment: "Average target internal rate of return percentage"
    - name: "avg_target_roe_pct"
      expr: AVG(CAST(target_roe_percent AS DOUBLE))
      comment: "Average target return on equity percentage"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate used in profitability calculations"
    - name: "avg_investment_yield_pct"
      expr: AVG(CAST(investment_yield_assumption_percent AS DOUBLE))
      comment: "Average assumed investment yield percentage"
    - name: "avg_expense_loading_pct"
      expr: AVG(CAST(expense_loading_percent AS DOUBLE))
      comment: "Average expense loading percentage"
    - name: "avg_commission_rate_year_1_pct"
      expr: AVG(CAST(commission_rate_year_1_percent AS DOUBLE))
      comment: "Average first-year commission rate percentage"
    - name: "avg_commission_rate_renewal_pct"
      expr: AVG(CAST(commission_rate_renewal_percent AS DOUBLE))
      comment: "Average renewal commission rate percentage"
    - name: "avg_lapse_rate_year_1_pct"
      expr: AVG(CAST(lapse_rate_year_1_percent AS DOUBLE))
      comment: "Average assumed first-year lapse rate percentage"
    - name: "avg_lapse_rate_ultimate_pct"
      expr: AVG(CAST(lapse_rate_ultimate_percent AS DOUBLE))
      comment: "Average assumed ultimate lapse rate percentage"
    - name: "avg_acquisition_expense_per_policy"
      expr: AVG(CAST(acquisition_expense_per_policy AS DOUBLE))
      comment: "Average acquisition expense per policy"
    - name: "avg_maintenance_expense_per_policy"
      expr: AVG(CAST(maintenance_expense_per_policy AS DOUBLE))
      comment: "Average maintenance expense per policy"
    - name: "avg_reinsurance_cession_pct"
      expr: AVG(CAST(reinsurance_cession_percent AS DOUBLE))
      comment: "Average reinsurance cession percentage"
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate percentage assumed"
    - name: "peer_reviewed_assumption_count"
      expr: COUNT(CASE WHEN peer_review_completed_flag = TRUE THEN 1 END)
      comment: "Count of assumption sets that completed peer review"
    - name: "sensitivity_tested_assumption_count"
      expr: COUNT(CASE WHEN sensitivity_test_performed_flag = TRUE THEN 1 END)
      comment: "Count of assumption sets with completed sensitivity testing"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_underwriting_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting class performance metrics tracking mortality experience, profitability, and risk classification effectiveness"
  source: "`life_insurance_ecm`.`product`.`underwriting_class`"
  dimensions:
    - name: "class_code"
      expr: class_code
      comment: "Unique code identifying the underwriting class"
    - name: "class_name"
      expr: class_name
      comment: "Business name of the underwriting class"
    - name: "class_category"
      expr: class_category
      comment: "Category grouping for the underwriting class"
    - name: "underwriting_class_status"
      expr: underwriting_class_status
      comment: "Current status of the underwriting class"
    - name: "tobacco_status"
      expr: tobacco_status
      comment: "Tobacco use classification"
    - name: "gender_specific_flag"
      expr: gender_specific_flag
      comment: "Whether class has gender-specific pricing"
    - name: "table_rating"
      expr: table_rating
      comment: "Table rating for substandard risk classification"
    - name: "reinsurance_eligible_flag"
      expr: reinsurance_eligible_flag
      comment: "Whether class is eligible for reinsurance"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "IRC Section 7702 compliance flag"
    - name: "principle_based_reserving_category"
      expr: principle_based_reserving_category
      comment: "Category for principle-based reserving requirements"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the underwriting class became effective"
  measures:
    - name: "underwriting_class_count"
      expr: COUNT(1)
      comment: "Total number of underwriting classes"
    - name: "avg_mortality_loading_factor"
      expr: AVG(CAST(mortality_loading_factor AS DOUBLE))
      comment: "Average mortality loading factor across underwriting classes"
    - name: "avg_experience_study_mortality_ratio"
      expr: AVG(CAST(experience_study_mortality_ratio AS DOUBLE))
      comment: "Average actual-to-expected mortality ratio from experience studies"
    - name: "avg_premium_loading_pct"
      expr: AVG(CAST(premium_loading_percentage AS DOUBLE))
      comment: "Average premium loading percentage"
    - name: "avg_profitability_target_margin"
      expr: AVG(CAST(profitability_target_margin AS DOUBLE))
      comment: "Average target profit margin for underwriting classes"
    - name: "avg_actual_profit_margin"
      expr: AVG(CAST(actual_profit_margin AS DOUBLE))
      comment: "Average actual profit margin achieved"
    - name: "avg_face_amount_maximum"
      expr: AVG(CAST(face_amount_maximum AS DOUBLE))
      comment: "Average maximum face amount for underwriting classes"
    - name: "avg_face_amount_minimum"
      expr: AVG(CAST(face_amount_minimum AS DOUBLE))
      comment: "Average minimum face amount for underwriting classes"
    - name: "avg_reinsurance_retention_limit"
      expr: AVG(CAST(reinsurance_retention_limit AS DOUBLE))
      comment: "Average reinsurance retention limit"
    - name: "avg_gpt_factor"
      expr: AVG(CAST(guideline_premium_test_factor AS DOUBLE))
      comment: "Average guideline premium test factor for IRC compliance"
    - name: "avg_cvat_factor"
      expr: AVG(CAST(cash_value_accumulation_test_factor AS DOUBLE))
      comment: "Average cash value accumulation test factor for IRC compliance"
    - name: "reinsurance_eligible_class_count"
      expr: COUNT(CASE WHEN reinsurance_eligible_flag = TRUE THEN 1 END)
      comment: "Count of underwriting classes eligible for reinsurance"
    - name: "gender_specific_class_count"
      expr: COUNT(CASE WHEN gender_specific_flag = TRUE THEN 1 END)
      comment: "Count of underwriting classes with gender-specific pricing"
    - name: "irc_compliant_class_count"
      expr: COUNT(CASE WHEN irc_7702_compliant_flag = TRUE THEN 1 END)
      comment: "Count of IRC 7702 compliant underwriting classes"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_expense_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product expense charge metrics tracking fee structures, charge rates, and profitability margins across product lines"
  source: "`life_insurance_ecm`.`product`.`expense_charge`"
  dimensions:
    - name: "charge_code"
      expr: charge_code
      comment: "Unique code identifying the expense charge"
    - name: "charge_name"
      expr: charge_name
      comment: "Business name of the expense charge"
    - name: "charge_type"
      expr: charge_type
      comment: "Type classification of the charge"
    - name: "expense_charge_status"
      expr: expense_charge_status
      comment: "Current status of the expense charge"
    - name: "charge_basis"
      expr: charge_basis
      comment: "Basis for calculating the charge (e.g., per policy, percentage of premium)"
    - name: "charge_frequency"
      expr: charge_frequency
      comment: "Frequency at which charge is assessed"
    - name: "charge_timing"
      expr: charge_timing
      comment: "Timing of charge assessment"
    - name: "applicable_product_line"
      expr: applicable_product_line
      comment: "Product line to which charge applies"
    - name: "dac_eligible_flag"
      expr: dac_eligible_flag
      comment: "Whether charge is eligible for deferred acquisition cost treatment"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "IRC Section 7702 compliance flag"
    - name: "illustration_disclosure_required_flag"
      expr: illustration_disclosure_required
      comment: "Whether charge must be disclosed in illustrations"
    - name: "reinsurance_ceded_indicator"
      expr: reinsurance_ceded_indicator
      comment: "Whether charge is ceded to reinsurer"
    - name: "surrender_charge_schedule_type"
      expr: surrender_charge_schedule_type
      comment: "Type of surrender charge schedule"
    - name: "gaap_revenue_classification"
      expr: gaap_revenue_classification
      comment: "GAAP revenue classification for the charge"
    - name: "statutory_accounting_treatment"
      expr: statutory_accounting_treatment
      comment: "Statutory accounting treatment for the charge"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the charge became effective"
  measures:
    - name: "expense_charge_count"
      expr: COUNT(1)
      comment: "Total number of expense charge definitions"
    - name: "avg_current_charge_rate"
      expr: AVG(CAST(current_charge_rate AS DOUBLE))
      comment: "Average current charge rate across all charges"
    - name: "avg_guaranteed_charge_rate"
      expr: AVG(CAST(guaranteed_charge_rate AS DOUBLE))
      comment: "Average guaranteed maximum charge rate"
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge amount"
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge amount"
    - name: "avg_profitability_target_margin"
      expr: AVG(CAST(profitability_target_margin AS DOUBLE))
      comment: "Average target profit margin for expense charges"
    - name: "avg_competitive_benchmark_rate"
      expr: AVG(CAST(competitive_benchmark_rate AS DOUBLE))
      comment: "Average competitive benchmark rate"
    - name: "avg_free_withdrawal_pct"
      expr: AVG(CAST(free_withdrawal_percentage AS DOUBLE))
      comment: "Average free withdrawal percentage before surrender charges apply"
    - name: "dac_eligible_charge_count"
      expr: COUNT(CASE WHEN dac_eligible_flag = TRUE THEN 1 END)
      comment: "Count of charges eligible for DAC treatment"
    - name: "irc_compliant_charge_count"
      expr: COUNT(CASE WHEN irc_7702_compliant_flag = TRUE THEN 1 END)
      comment: "Count of IRC 7702 compliant charges"
    - name: "illustration_disclosure_required_count"
      expr: COUNT(CASE WHEN illustration_disclosure_required = TRUE THEN 1 END)
      comment: "Count of charges requiring illustration disclosure"
    - name: "reinsurance_ceded_charge_count"
      expr: COUNT(CASE WHEN reinsurance_ceded_indicator = TRUE THEN 1 END)
      comment: "Count of charges ceded to reinsurer"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`product_crediting_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Indexed and fixed crediting strategy metrics tracking cap rates, participation rates, and investment return parameters for annuity and universal life products"
  source: "`life_insurance_ecm`.`product`.`crediting_strategy`"
  dimensions:
    - name: "strategy_code"
      expr: strategy_code
      comment: "Unique code identifying the crediting strategy"
    - name: "strategy_name"
      expr: strategy_name
      comment: "Business name of the crediting strategy"
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of crediting strategy (indexed, fixed, etc.)"
    - name: "strategy_availability_status"
      expr: strategy_availability_status
      comment: "Current availability status of the strategy"
    - name: "crediting_method"
      expr: crediting_method
      comment: "Method used to calculate credited interest"
    - name: "index_type"
      expr: index_type
      comment: "Market index used for indexed strategies"
    - name: "index_calculation_method"
      expr: index_calculation_method
      comment: "Method for calculating index performance"
    - name: "reset_frequency"
      expr: reset_frequency
      comment: "Frequency at which strategy resets"
    - name: "hedging_cost_basis"
      expr: hedging_cost_basis
      comment: "Basis for hedging cost allocation"
    - name: "irc_7702_compliant_flag"
      expr: irc_7702_compliant_flag
      comment: "IRC Section 7702 compliance flag"
    - name: "renewal_rate_adjustment_flag"
      expr: renewal_rate_adjustment_flag
      comment: "Whether renewal rates can be adjusted"
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target market segment for the strategy"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the strategy became effective"
  measures:
    - name: "crediting_strategy_count"
      expr: COUNT(1)
      comment: "Total number of crediting strategies"
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average cap rate limiting maximum credited interest"
    - name: "avg_floor_rate"
      expr: AVG(CAST(floor_rate AS DOUBLE))
      comment: "Average floor rate guaranteeing minimum credited interest"
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate in index performance"
    - name: "avg_spread_rate"
      expr: AVG(CAST(spread_rate AS DOUBLE))
      comment: "Average spread rate deducted from index performance"
    - name: "avg_buffer_rate"
      expr: AVG(CAST(buffer_rate AS DOUBLE))
      comment: "Average buffer rate protecting against initial losses"
    - name: "avg_declared_rate"
      expr: AVG(CAST(declared_rate AS DOUBLE))
      comment: "Average declared interest rate for fixed strategies"
    - name: "avg_guaranteed_minimum_rate"
      expr: AVG(CAST(guaranteed_minimum_rate AS DOUBLE))
      comment: "Average guaranteed minimum interest rate"
    - name: "avg_illustration_rate"
      expr: AVG(CAST(illustration_rate AS DOUBLE))
      comment: "Average rate used in product illustrations"
    - name: "avg_historical_average_credit_rate"
      expr: AVG(CAST(historical_average_credit_rate AS DOUBLE))
      comment: "Average historical credited interest rate"
    - name: "avg_allocation_maximum_pct"
      expr: AVG(CAST(allocation_maximum_pct AS DOUBLE))
      comment: "Average maximum allocation percentage to strategy"
    - name: "avg_allocation_minimum_pct"
      expr: AVG(CAST(allocation_minimum_pct AS DOUBLE))
      comment: "Average minimum allocation percentage to strategy"
    - name: "irc_compliant_strategy_count"
      expr: COUNT(CASE WHEN irc_7702_compliant_flag = TRUE THEN 1 END)
      comment: "Count of IRC 7702 compliant crediting strategies"
    - name: "renewable_strategy_count"
      expr: COUNT(CASE WHEN renewal_rate_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of strategies with renewable rate adjustments"
$$;