-- Metric views for domain: employer | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employer group metrics covering group portfolio health, risk profile, and enrollment composition for strategic decision-making."
  source: "`health_insurance_ecm`.`employer`.`group`"
  dimensions:
    - name: "group_status"
      expr: group_status
      comment: "Current status of the employer group (active, terminated, pending, etc.)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification (small group, large group, jumbo, etc.)"
    - name: "size_tier"
      expr: size_tier
      comment: "Size tier classification of the employer group based on employee count"
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type (fully insured, self-funded, level-funded, etc.)"
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for the employer group"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the group is enrolled in (medical, dental, vision, etc.)"
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status of the employer group"
    - name: "contribution_strategy"
      expr: contribution_strategy
      comment: "Employer contribution strategy (defined contribution, defined benefit, etc.)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the group became effective"
    - name: "renewal_month"
      expr: MONTH(renewal_date)
      comment: "Month of the group renewal date for seasonal analysis"
  measures:
    - name: "total_active_groups"
      expr: COUNT(CASE WHEN group_status = 'Active' THEN 1 END)
      comment: "Total number of active employer groups in the portfolio"
    - name: "total_groups"
      expr: COUNT(1)
      comment: "Total number of employer groups across all statuses"
    - name: "avg_claim_cost_per_group"
      expr: AVG(CAST(average_claim_cost AS DOUBLE))
      comment: "Average claim cost per employer group, key indicator of group risk profile"
    - name: "total_average_claim_cost"
      expr: SUM(CAST(average_claim_cost AS DOUBLE))
      comment: "Aggregate of average claim costs across all groups for portfolio-level cost analysis"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Mean risk adjustment factor across groups, indicating overall portfolio risk level"
    - name: "distinct_domicile_states"
      expr: COUNT(DISTINCT domicile_state)
      comment: "Number of distinct states represented in the group portfolio for geographic diversification analysis"
    - name: "self_funded_group_count"
      expr: COUNT(CASE WHEN funding_arrangement = 'Self-Funded' THEN 1 END)
      comment: "Count of self-funded employer groups, critical for stop-loss and ASO fee planning"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group renewal metrics tracking retention, rate changes, and renewal pipeline health — critical for revenue forecasting and retention strategy."
  source: "`health_insurance_ecm`.`employer`.`group_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (pending, approved, declined, in-progress, etc.)"
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement type for the renewal"
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status at renewal"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status at time of renewal"
    - name: "retention_outcome"
      expr: retention_outcome
      comment: "Outcome of the renewal retention effort (retained, lost, etc.)"
    - name: "renewal_cycle_year"
      expr: renewal_cycle_year
      comment: "Year of the renewal cycle for trend analysis"
    - name: "group_size"
      expr: group_size
      comment: "Size classification of the group at renewal"
    - name: "sic_code"
      expr: sic_code
      comment: "Standard Industrial Classification code of the group for industry-level analysis"
    - name: "renewal_effective_month"
      expr: MONTH(renewal_effective_date)
      comment: "Month of renewal effective date for seasonal pipeline analysis"
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total number of group renewal records"
    - name: "avg_rate_change_pct"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage across renewals, key pricing trend indicator"
    - name: "total_prior_year_premium"
      expr: SUM(CAST(premium_rate_prior_year AS DOUBLE))
      comment: "Total prior year premium across all renewals for revenue baseline"
    - name: "total_renewal_year_premium"
      expr: SUM(CAST(premium_rate_renewal_year AS DOUBLE))
      comment: "Total renewal year premium across all renewals for revenue projection"
    - name: "retained_group_count"
      expr: COUNT(CASE WHEN retention_outcome = 'Retained' THEN 1 END)
      comment: "Number of groups retained through the renewal process"
    - name: "lost_group_count"
      expr: COUNT(CASE WHEN retention_outcome = 'Lost' THEN 1 END)
      comment: "Number of groups lost during the renewal process"
    - name: "amended_renewal_count"
      expr: COUNT(CASE WHEN amendment_flag = TRUE THEN 1 END)
      comment: "Number of renewals that required amendments, indicating negotiation complexity"
    - name: "compliant_renewal_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of renewals meeting regulatory compliance requirements"
    - name: "avg_latest_amendment_change"
      expr: AVG(CAST(latest_amendment_after_value - latest_amendment_before_value AS DOUBLE))
      comment: "Average monetary impact of the latest amendment per renewal"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate quote metrics for tracking quoting activity, premium estimates, and pricing competitiveness — essential for sales pipeline and pricing strategy."
  source: "`health_insurance_ecm`.`employer`.`rate_quote`"
  dimensions:
    - name: "rate_quote_status"
      expr: rate_quote_status
      comment: "Current status of the rate quote (draft, issued, accepted, declined, expired)"
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology used (community, experience, blended, etc.)"
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for the quote"
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier (employee only, employee+spouse, family, etc.)"
    - name: "group_type"
      expr: group_type
      comment: "Type of employer group being quoted"
    - name: "group_size"
      expr: group_size
      comment: "Size classification of the group being quoted"
    - name: "contribution_strategy"
      expr: contribution_strategy
      comment: "Contribution strategy associated with the quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quoted premium amounts"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the rate quote"
    - name: "quote_effective_month"
      expr: MONTH(effective_date)
      comment: "Month of quote effective date for seasonal analysis"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of rate quotes generated"
    - name: "total_gross_premium"
      expr: SUM(CAST(gross_premium_amount AS DOUBLE))
      comment: "Total gross premium across all quotes for revenue pipeline estimation"
    - name: "total_net_premium"
      expr: SUM(CAST(net_premium_amount AS DOUBLE))
      comment: "Total net premium across all quotes after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across quotes, measuring pricing concessions"
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate across quotes, key pricing benchmark"
    - name: "avg_group_premium_estimate"
      expr: AVG(CAST(total_group_premium_estimate AS DOUBLE))
      comment: "Average total group premium estimate per quote"
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN rate_quote_status = 'Accepted' THEN 1 END)
      comment: "Number of quotes accepted by employer groups"
    - name: "expired_quote_count"
      expr: COUNT(CASE WHEN rate_quote_status = 'Expired' THEN 1 END)
      comment: "Number of quotes that expired without action, indicating pipeline leakage"
    - name: "distinct_groups_quoted"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups that received rate quotes"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting case metrics tracking risk assessment, pricing accuracy, and underwriting pipeline — critical for risk management and profitability."
  source: "`health_insurance_ecm`.`employer`.`employer_underwriting_case`"
  dimensions:
    - name: "underwriting_status"
      expr: underwriting_status
      comment: "Current status of the underwriting case"
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Final underwriting decision (approved, declined, referred, etc.)"
    - name: "quote_status"
      expr: quote_status
      comment: "Status of the associated quote"
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology applied in underwriting"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification assigned to the group"
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code"
    - name: "industry_risk_factor"
      expr: industry_risk_factor
      comment: "Industry-based risk factor classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of premium estimates"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year of underwriting case submission"
  measures:
    - name: "total_underwriting_cases"
      expr: COUNT(1)
      comment: "Total number of underwriting cases submitted"
    - name: "avg_pmpm_estimate"
      expr: AVG(CAST(pmpm_estimate AS DOUBLE))
      comment: "Average per-member-per-month estimate across underwriting cases"
    - name: "total_premium_estimate"
      expr: SUM(CAST(total_premium_estimate AS DOUBLE))
      comment: "Total estimated premium across all underwriting cases"
    - name: "avg_experience_rating_factor"
      expr: AVG(CAST(experience_rating_factor AS DOUBLE))
      comment: "Average experience rating factor, indicating portfolio claims experience"
    - name: "avg_group_average_age"
      expr: AVG(CAST(group_average_age AS DOUBLE))
      comment: "Average age across underwritten groups, key demographic risk indicator"
    - name: "avg_age_gender_composite_factor"
      expr: AVG(CAST(age_gender_composite_factor AS DOUBLE))
      comment: "Average age-gender composite factor for demographic risk assessment"
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic factor reflecting regional cost variation"
    - name: "approved_case_count"
      expr: COUNT(CASE WHEN underwriting_decision = 'Approved' THEN 1 END)
      comment: "Number of underwriting cases approved"
    - name: "declined_case_count"
      expr: COUNT(CASE WHEN underwriting_decision = 'Declined' THEN 1 END)
      comment: "Number of underwriting cases declined, indicating risk appetite boundaries"
    - name: "manual_rate_basis_count"
      expr: COUNT(CASE WHEN manual_rate_basis = TRUE THEN 1 END)
      comment: "Number of cases using manual rate basis vs experience rating"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan offering metrics tracking employer benefit design, contribution levels, and participation — essential for product strategy and ACA compliance."
  source: "`health_insurance_ecm`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "group_plan_offering_status"
      expr: group_plan_offering_status
      comment: "Status of the plan offering (active, terminated, pending)"
    - name: "offering_type"
      expr: offering_type
      comment: "Type of plan offering (medical, dental, vision, etc.)"
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of employer contribution (fixed dollar, percentage, tiered)"
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier level (employee only, employee+spouse, family, etc.)"
    - name: "participation_status"
      expr: participation_status
      comment: "Participation status relative to minimum requirements"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the offering"
    - name: "is_affordable"
      expr: CASE WHEN is_affordable = TRUE THEN 'Affordable' ELSE 'Not Affordable' END
      comment: "ACA affordability classification of the offering"
    - name: "waiver_eligible"
      expr: CASE WHEN waiver_eligible = TRUE THEN 'Waiver Eligible' ELSE 'Not Waiver Eligible' END
      comment: "Whether the offering allows employee waivers"
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of plan offerings across all groups"
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering"
    - name: "total_employer_contribution"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount across all offerings"
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount per offering"
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage across offerings"
    - name: "avg_minimum_participation_pct"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation percentage required across offerings"
    - name: "total_hsa_seed_amount"
      expr: SUM(CAST(hsa_seed_amount AS DOUBLE))
      comment: "Total HSA seed amounts contributed by employers across offerings"
    - name: "total_hra_seed_amount"
      expr: SUM(CAST(hra_seed_amount AS DOUBLE))
      comment: "Total HRA seed amounts contributed by employers across offerings"
    - name: "affordable_offering_count"
      expr: COUNT(CASE WHEN is_affordable = TRUE THEN 1 END)
      comment: "Number of offerings classified as ACA-affordable"
    - name: "distinct_groups_with_offerings"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with active plan offerings"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_stop_loss_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-loss policy metrics for self-funded risk management — tracking attachment points, premiums, and coverage adequacy."
  source: "`health_insurance_ecm`.`employer`.`stop_loss_policy`"
  dimensions:
    - name: "stop_loss_policy_status"
      expr: stop_loss_policy_status
      comment: "Current status of the stop-loss policy"
    - name: "policy_type"
      expr: policy_type
      comment: "Type of stop-loss policy (specific, aggregate, or both)"
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Type of attachment point (individual, aggregate)"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Stop-loss carrier/reinsurer name"
    - name: "contribution_strategy"
      expr: contribution_strategy
      comment: "Contribution strategy associated with the stop-loss policy"
    - name: "lasering_provision"
      expr: CASE WHEN lasering_provision_flag = TRUE THEN 'Lasered' ELSE 'Standard' END
      comment: "Whether the policy includes lasering provisions for high-risk individuals"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the stop-loss policy became effective"
  measures:
    - name: "total_stop_loss_policies"
      expr: COUNT(1)
      comment: "Total number of stop-loss policies in force"
    - name: "total_stop_loss_premium"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total stop-loss premium across all policies"
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(individual_attachment_point AS DOUBLE))
      comment: "Average individual specific attachment point, indicating per-claimant risk retention level"
    - name: "avg_aggregate_attachment_point"
      expr: AVG(CAST(aggregate_attachment_point AS DOUBLE))
      comment: "Average aggregate attachment point across policies"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across stop-loss policies"
    - name: "total_claim_payment_limit"
      expr: SUM(CAST(claim_payment_limit AS DOUBLE))
      comment: "Total claim payment limit exposure across all stop-loss policies"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to stop-loss policies"
    - name: "lasered_policy_count"
      expr: COUNT(CASE WHEN lasering_provision_flag = TRUE THEN 1 END)
      comment: "Number of policies with lasering provisions, indicating high-risk member exclusions"
    - name: "distinct_groups_covered"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with stop-loss coverage"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker assignment metrics tracking distribution channel effectiveness, commission costs, and broker-group relationships."
  source: "`health_insurance_ecm`.`employer`.`broker_assignment`"
  dimensions:
    - name: "broker_assignment_status"
      expr: broker_assignment_status
      comment: "Current status of the broker assignment"
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission arrangement (percentage, flat fee, PEPM, etc.)"
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (premium, enrollment, etc.)"
    - name: "is_primary"
      expr: CASE WHEN is_primary = TRUE THEN 'Primary' ELSE 'Secondary' END
      comment: "Whether this is the primary broker assignment for the group"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the broker agency"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the broker assignment became effective"
  measures:
    - name: "total_broker_assignments"
      expr: COUNT(1)
      comment: "Total number of broker-group assignments"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across broker assignments"
    - name: "distinct_brokers_assigned"
      expr: COUNT(DISTINCT broker_id)
      comment: "Number of distinct brokers with active group assignments"
    - name: "distinct_groups_with_brokers"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with broker assignments"
    - name: "primary_assignment_count"
      expr: COUNT(CASE WHEN is_primary = TRUE THEN 1 END)
      comment: "Number of primary broker assignments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contribution strategy metrics tracking employer benefit funding levels, tax optimization, and ACA affordability compliance."
  source: "`health_insurance_ecm`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "contribution_strategy_status"
      expr: contribution_strategy_status
      comment: "Status of the contribution strategy"
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of contribution (defined contribution, defined benefit, etc.)"
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of employer contributions (monthly, bi-weekly, etc.)"
    - name: "tier_code"
      expr: tier_code
      comment: "Coverage tier code for the contribution strategy"
    - name: "is_pre_tax"
      expr: CASE WHEN is_pre_tax = TRUE THEN 'Pre-Tax' ELSE 'Post-Tax' END
      comment: "Whether contributions are pre-tax (Section 125)"
    - name: "tax_credit_eligible"
      expr: CASE WHEN tax_credit_eligible = TRUE THEN 'Eligible' ELSE 'Not Eligible' END
      comment: "Whether the strategy qualifies for small business tax credits"
    - name: "affordability_test"
      expr: CASE WHEN affordability_test_flag = TRUE THEN 'Passes Affordability' ELSE 'Fails Affordability' END
      comment: "ACA affordability test result"
    - name: "review_status"
      expr: review_status
      comment: "Review status of the contribution strategy"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contribution strategy became effective"
  measures:
    - name: "total_contribution_strategies"
      expr: COUNT(1)
      comment: "Total number of contribution strategies defined"
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per strategy"
    - name: "avg_contribution_percentage"
      expr: AVG(CAST(contribution_percentage AS DOUBLE))
      comment: "Average employer contribution percentage across strategies"
    - name: "avg_employer_contribution_cap"
      expr: AVG(CAST(employer_contribution_cap AS DOUBLE))
      comment: "Average employer contribution cap amount"
    - name: "total_hsa_employer_seed"
      expr: SUM(CAST(hsa_employer_seed_amount AS DOUBLE))
      comment: "Total HSA employer seed amounts across all strategies"
    - name: "total_hra_employer_seed"
      expr: SUM(CAST(hra_employer_seed_amount AS DOUBLE))
      comment: "Total HRA employer seed amounts across all strategies"
    - name: "avg_max_employee_contribution"
      expr: AVG(CAST(maximum_employee_contribution AS DOUBLE))
      comment: "Average maximum employee contribution limit"
    - name: "affordability_pass_count"
      expr: COUNT(CASE WHEN affordability_test_flag = TRUE THEN 1 END)
      comment: "Number of strategies passing ACA affordability test"
    - name: "distinct_groups_with_strategies"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with defined contribution strategies"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_tpa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TPA arrangement metrics tracking third-party administrator costs, stop-loss coverage, and self-funded administration efficiency."
  source: "`health_insurance_ecm`.`employer`.`tpa_arrangement`"
  dimensions:
    - name: "tpa_arrangement_status"
      expr: tpa_arrangement_status
      comment: "Current status of the TPA arrangement"
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of TPA arrangement (ASO, full service, etc.)"
    - name: "fee_schedule_type"
      expr: fee_schedule_type
      comment: "Type of fee schedule (PEPM, percentage, flat, etc.)"
    - name: "contribution_strategy"
      expr: contribution_strategy
      comment: "Contribution strategy associated with the TPA arrangement"
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status of the arrangement"
    - name: "stop_loss_coverage_scope"
      expr: stop_loss_coverage_scope
      comment: "Scope of stop-loss coverage (specific, aggregate, both)"
    - name: "stop_loss_carrier_name"
      expr: stop_loss_carrier_name
      comment: "Name of the stop-loss carrier"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the TPA arrangement became effective"
  measures:
    - name: "total_tpa_arrangements"
      expr: COUNT(1)
      comment: "Total number of TPA arrangements"
    - name: "avg_fee_schedule_rate_pmpm"
      expr: AVG(CAST(fee_schedule_rate_pmpm AS DOUBLE))
      comment: "Average PEPM fee schedule rate across TPA arrangements"
    - name: "total_stop_loss_premium"
      expr: SUM(CAST(stop_loss_premium AS DOUBLE))
      comment: "Total stop-loss premium across all TPA arrangements"
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(stop_loss_individual_attachment_point AS DOUBLE))
      comment: "Average individual stop-loss attachment point across arrangements"
    - name: "avg_aggregate_deductible"
      expr: AVG(CAST(stop_loss_aggregate_deductible AS DOUBLE))
      comment: "Average aggregate stop-loss deductible across arrangements"
    - name: "avg_contribution_rate_pmpm"
      expr: AVG(CAST(contribution_rate_pmpm AS DOUBLE))
      comment: "Average contribution rate PMPM across TPA arrangements"
    - name: "total_fee_schedule_cap"
      expr: SUM(CAST(fee_schedule_cap_amount AS DOUBLE))
      comment: "Total fee schedule cap amounts across all arrangements"
    - name: "avg_stop_loss_laser_amount"
      expr: AVG(CAST(stop_loss_laser_amount AS DOUBLE))
      comment: "Average laser amount for high-risk individuals across arrangements"
    - name: "distinct_tpas"
      expr: COUNT(DISTINCT tpa_id)
      comment: "Number of distinct TPAs managing employer arrangements"
    - name: "distinct_groups_with_tpa"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with TPA arrangements"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_wellness_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program metrics tracking program investment, participation effectiveness, and ROI potential — key for population health management strategy."
  source: "`health_insurance_ecm`.`employer`.`wellness_program`"
  dimensions:
    - name: "wellness_program_status"
      expr: wellness_program_status
      comment: "Current status of the wellness program"
    - name: "program_type"
      expr: program_type
      comment: "Type of wellness program (preventive, chronic disease management, fitness, etc.)"
    - name: "program_category"
      expr: program_category
      comment: "Category classification of the wellness program"
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered (premium discount, gift card, HSA contribution, etc.)"
    - name: "participation_method"
      expr: participation_method
      comment: "Method of participation (online, in-person, hybrid)"
    - name: "is_mandatory"
      expr: CASE WHEN is_mandatory = TRUE THEN 'Mandatory' ELSE 'Voluntary' END
      comment: "Whether the wellness program is mandatory or voluntary"
    - name: "aca_compliance_classification"
      expr: aca_compliance_classification
      comment: "ACA compliance classification for the wellness program"
    - name: "program_review_status"
      expr: program_review_status
      comment: "Review status of the wellness program"
    - name: "program_effective_year"
      expr: program_effective_year
      comment: "Effective year of the wellness program"
  measures:
    - name: "total_wellness_programs"
      expr: COUNT(1)
      comment: "Total number of wellness programs offered"
    - name: "total_program_budget"
      expr: SUM(CAST(program_budget_amount AS DOUBLE))
      comment: "Total budget allocated across all wellness programs"
    - name: "avg_program_budget"
      expr: AVG(CAST(program_budget_amount AS DOUBLE))
      comment: "Average budget per wellness program"
    - name: "avg_actual_participation_pct"
      expr: AVG(CAST(program_actual_participation_pct AS DOUBLE))
      comment: "Average actual participation rate across wellness programs"
    - name: "avg_target_participation_pct"
      expr: AVG(CAST(program_target_participation_pct AS DOUBLE))
      comment: "Average target participation rate across wellness programs"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive amounts offered across all wellness programs"
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per wellness program"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(program_risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor for wellness programs, indicating expected impact on claims"
    - name: "tax_credit_eligible_count"
      expr: COUNT(CASE WHEN is_eligible_for_tax_credit = TRUE THEN 1 END)
      comment: "Number of wellness programs eligible for tax credits"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contract metrics tracking contract portfolio value and status for vendor and group relationship management."
  source: "`health_insurance_ecm`.`employer`.`employer_contract`"
  dimensions:
    - name: "employer_contract_status"
      expr: employer_contract_status
      comment: "Current status of the employer contract"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "annual_review_month"
      expr: MONTH(annual_review_date)
      comment: "Month of annual contract review"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of employer contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all employer contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value across all employer contracts"
    - name: "distinct_groups_under_contract"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with active contracts"
    - name: "distinct_vendors_contracted"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with employer contracts"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`employer_open_enrollment_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open enrollment window metrics tracking enrollment activity, participation rates, and enrollment window management effectiveness."
  source: "`health_insurance_ecm`.`employer`.`open_enrollment_window`"
  dimensions:
    - name: "enrollment_window_status"
      expr: enrollment_window_status
      comment: "Current status of the enrollment window"
    - name: "enrollment_window_type"
      expr: enrollment_window_type
      comment: "Type of enrollment window (annual open enrollment, special enrollment, new hire, etc.)"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage for the enrollment window"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method of enrollment (online, paper, phone, etc.)"
    - name: "waiver_allowed"
      expr: CASE WHEN waiver_allowed = TRUE THEN 'Waiver Allowed' ELSE 'Waiver Not Allowed' END
      comment: "Whether waivers are permitted during this enrollment window"
    - name: "plan_selection_method"
      expr: plan_selection_method
      comment: "Method for plan selection during enrollment"
    - name: "enrollment_start_year"
      expr: YEAR(start_date)
      comment: "Year the enrollment window opens"
  measures:
    - name: "total_enrollment_windows"
      expr: COUNT(1)
      comment: "Total number of open enrollment windows"
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average participation rate across enrollment windows"
    - name: "distinct_groups_with_enrollment"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with open enrollment windows"
$$;