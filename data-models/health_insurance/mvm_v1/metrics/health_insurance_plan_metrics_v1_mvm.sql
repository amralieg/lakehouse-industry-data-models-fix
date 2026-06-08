-- Metric views for domain: plan | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core health plan performance metrics including enrollment capacity, premium revenue, and plan utilization across market segments and regulatory classifications"
  source: "`health_insurance_ecm`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for temporal analysis of plan performance"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, etc.)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group, etc.)"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, POS, HDHP, etc.)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the health plan (Active, Inactive, Pending, Terminated)"
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered"
    - name: "plan_region"
      expr: plan_region
      comment: "Geographic region for the plan"
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category classification"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan"
    - name: "plan_aca_compliant"
      expr: plan_aca_compliant
      comment: "Whether the plan is ACA compliant"
    - name: "plan_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Whether the plan is eligible for marketplace enrollment"
    - name: "is_exempt_from_mlr"
      expr: is_exempt_from_mlr
      comment: "Whether the plan is exempt from Medical Loss Ratio requirements"
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for the plan"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of health plans"
    - name: "total_premium_revenue"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium revenue across all plans"
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount per plan"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible amount across plans"
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible amount across plans"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across plans"
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum across plans"
    - name: "avg_coinsurance_percentage"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay amount across plans"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay amount across plans"
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across plans, indicating population health risk"
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average Hierarchical Condition Category score across plans, measuring member acuity"
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN plan_aca_compliant = true THEN 1 END)
      comment: "Number of ACA-compliant plans"
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(CASE WHEN plan_marketplace_eligible = true THEN 1 END)
      comment: "Number of marketplace-eligible plans"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package design metrics including actuarial value, cost-sharing structures, and pharmacy benefit configurations across metal tiers"
  source: "`health_insurance_ecm`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "Metal tier classification (Bronze, Silver, Gold, Platinum, Catastrophic)"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the benefit package"
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package"
    - name: "deductible_type"
      expr: deductible_type
      comment: "Type of deductible structure (embedded, aggregate, etc.)"
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Whether generic substitution is required"
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required"
    - name: "specialty_drug_management_program"
      expr: specialty_drug_management_program
      comment: "Specialty drug management program designation"
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(1)
      comment: "Total number of benefit packages"
    - name: "avg_actuarial_value"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across benefit packages, indicating plan richness"
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount"
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount"
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum"
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay"
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay"
    - name: "avg_inpatient_coinsurance"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate"
    - name: "avg_outpatient_coinsurance"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate"
    - name: "avg_retail_generic_copay"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay"
    - name: "avg_retail_brand_copay"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay"
    - name: "avg_mail_order_generic_copay"
      expr: AVG(CAST(mail_order_copay_generic AS DOUBLE))
      comment: "Average mail order generic drug copay"
    - name: "avg_mail_order_brand_copay"
      expr: AVG(CAST(mail_order_copay_brand AS DOUBLE))
      comment: "Average mail order brand drug copay"
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate metrics including age-rated premiums, tobacco surcharges, and rate variations across rating areas and family tiers"
  source: "`health_insurance_ecm`.`plan`.`rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for rate analysis"
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Individual, Employee+Spouse, Employee+Children, Family)"
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Rating area code for geographic rate variation"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate"
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (base, composite, age-rated, etc.)"
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation for rate classification"
    - name: "underwriting_class_code"
      expr: underwriting_class_code
      comment: "Underwriting class code"
    - name: "is_tobacco_surcharge_applicable"
      expr: is_tobacco_surcharge_applicable
      comment: "Whether tobacco surcharge applies"
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Tobacco use indicator"
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory filing"
  measures:
    - name: "total_rates"
      expr: COUNT(1)
      comment: "Total number of rate records"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all rate records"
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium amount"
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium amount"
    - name: "avg_tobacco_surcharge"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount"
    - name: "total_premium_revenue"
      expr: SUM(CAST(family_tier_premium AS DOUBLE))
      comment: "Total premium revenue from family tier premiums"
    - name: "tobacco_surcharge_rate_count"
      expr: COUNT(CASE WHEN is_tobacco_surcharge_applicable = true THEN 1 END)
      comment: "Number of rates with tobacco surcharge applicable"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual benefit-level metrics including cost-sharing structures, coverage limits, authorization requirements, and regulatory compliance across benefit categories"
  source: "`health_insurance_ecm`.`plan`.`benefit`"
  dimensions:
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category (Medical, Pharmacy, Dental, Vision, etc.)"
    - name: "benefit_group"
      expr: benefit_group
      comment: "Benefit group classification"
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage provided"
    - name: "cost_sharing_type"
      expr: cost_sharing_type
      comment: "Type of cost sharing (copay, coinsurance, deductible)"
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether authorization is required for this benefit"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization required"
    - name: "prior_auth_review_level"
      expr: prior_auth_review_level
      comment: "Level of prior authorization review"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the benefit is mandatory"
    - name: "is_exempt"
      expr: is_exempt
      comment: "Whether the benefit is exempt from certain requirements"
    - name: "preventive_service_flag"
      expr: preventive_service_flag
      comment: "Whether the benefit is a preventive service"
    - name: "wellness_mandate_flag"
      expr: wellness_mandate_flag
      comment: "Whether the benefit is a wellness mandate"
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit classification"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the benefit"
    - name: "limit_type"
      expr: limit_type
      comment: "Type of benefit limit"
    - name: "limit_period"
      expr: limit_period
      comment: "Period for benefit limit (annual, lifetime, etc.)"
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the benefit"
  measures:
    - name: "total_benefits"
      expr: COUNT(1)
      comment: "Total number of benefit records"
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost sharing amount across benefits"
    - name: "avg_cost_sharing_percent"
      expr: AVG(CAST(cost_sharing_percent AS DOUBLE))
      comment: "Average cost sharing percentage across benefits"
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value"
    - name: "avg_oop_max"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum amount"
    - name: "avg_moop_max"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average maximum out-of-pocket amount"
    - name: "authorization_required_count"
      expr: COUNT(CASE WHEN authorization_required = true THEN 1 END)
      comment: "Number of benefits requiring authorization"
    - name: "mandatory_benefit_count"
      expr: COUNT(CASE WHEN is_mandatory = true THEN 1 END)
      comment: "Number of mandatory benefits"
    - name: "preventive_service_count"
      expr: COUNT(CASE WHEN preventive_service_flag = true THEN 1 END)
      comment: "Number of preventive service benefits"
    - name: "wellness_mandate_count"
      expr: COUNT(CASE WHEN wellness_mandate_flag = true THEN 1 END)
      comment: "Number of wellness mandate benefits"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule metrics including deductibles, copays, coinsurance rates, and out-of-pocket maximums across network types and member tiers"
  source: "`health_insurance_ecm`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule"
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Category of cost sharing"
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Current status of the cost-sharing rule"
    - name: "network_type"
      expr: network_type
      comment: "Network type (in-network, out-of-network)"
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier for cost sharing"
    - name: "after_deductible"
      expr: after_deductible
      comment: "Whether cost sharing applies after deductible"
    - name: "prior_to_deductible"
      expr: prior_to_deductible
      comment: "Whether cost sharing applies prior to deductible"
    - name: "deductible_aggregate_flag"
      expr: deductible_aggregate_flag
      comment: "Whether deductible is aggregate"
    - name: "deductible_embedded_flag"
      expr: deductible_embedded_flag
      comment: "Whether deductible is embedded"
    - name: "hsa_compatible"
      expr: hsa_compatible
      comment: "Whether the rule is HSA compatible"
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Whether this is the default rule"
    - name: "applies_to_service_category"
      expr: applies_to_service_category
      comment: "Service category the rule applies to"
    - name: "applies_to_drug"
      expr: applies_to_drug
      comment: "Whether rule applies to drugs"
    - name: "applies_to_procedure"
      expr: applies_to_procedure
      comment: "Whether rule applies to procedures"
    - name: "applies_to_ancillary"
      expr: applies_to_ancillary
      comment: "Whether rule applies to ancillary services"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the rule"
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(1)
      comment: "Total number of cost-sharing rules"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across rules"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across rules"
    - name: "avg_copay_oon"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate across rules"
    - name: "avg_coinsurance_rate_oon"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate"
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum"
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum"
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount"
    - name: "avg_accumulator_threshold"
      expr: AVG(CAST(accumulator_threshold AS DOUBLE))
      comment: "Average accumulator threshold amount"
    - name: "hsa_compatible_rule_count"
      expr: COUNT(CASE WHEN hsa_compatible = true THEN 1 END)
      comment: "Number of HSA-compatible cost-sharing rules"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan offering metrics including employer contribution strategies, enrollment periods, and offering configurations across groups and renewal cycles"
  source: "`health_insurance_ecm`.`plan`.`offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of offering"
    - name: "offering_status"
      expr: offering_status
      comment: "Current status of the offering"
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of employer contribution (fixed, percentage, etc.)"
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (employee-only, employee+spouse, family, etc.)"
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of plan offerings"
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount"
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage"
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount"
    - name: "avg_family_contribution"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount"
    - name: "total_employer_contribution"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total employer contribution across all offerings"
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution across all offerings"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_hsa_hra_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Savings Account and Health Reimbursement Arrangement configuration metrics including contribution limits, rollover rules, and regulatory compliance"
  source: "`health_insurance_ecm`.`plan`.`hsa_hra_config`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of account (HSA, HRA, etc.)"
    - name: "hsa_hra_config_status"
      expr: hsa_hra_config_status
      comment: "Current status of the HSA/HRA configuration"
    - name: "contribution_method"
      expr: contribution_method
      comment: "Method of contribution"
    - name: "contribution_source"
      expr: contribution_source
      comment: "Source of contribution (employer, employee, both)"
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of contributions"
    - name: "contribution_limit_type"
      expr: contribution_limit_type
      comment: "Type of contribution limit"
    - name: "eligibility_hdpp"
      expr: eligibility_hdpp
      comment: "Whether eligible for High Deductible Health Plan"
    - name: "rollover_allowed"
      expr: rollover_allowed
      comment: "Whether rollover is allowed"
    - name: "use_it_or_lose_it_flag"
      expr: use_it_or_lose_it_flag
      comment: "Whether use-it-or-lose-it rule applies"
    - name: "grace_period_option"
      expr: grace_period_option
      comment: "Whether grace period option is available"
    - name: "catch_up_contribution_eligible"
      expr: catch_up_contribution_eligible
      comment: "Whether catch-up contributions are eligible"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether configuration is regulatory compliant"
  measures:
    - name: "total_hsa_hra_configs"
      expr: COUNT(1)
      comment: "Total number of HSA/HRA configurations"
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount"
    - name: "avg_employee_contribution_limit"
      expr: AVG(CAST(employee_contribution_limit AS DOUBLE))
      comment: "Average employee contribution limit"
    - name: "avg_contribution_limit"
      expr: AVG(CAST(contribution_limit_amount AS DOUBLE))
      comment: "Average total contribution limit"
    - name: "avg_catch_up_contribution"
      expr: AVG(CAST(catch_up_contribution_amount AS DOUBLE))
      comment: "Average catch-up contribution amount for eligible members"
    - name: "avg_rollover_limit"
      expr: AVG(CAST(rollover_limit_amount AS DOUBLE))
      comment: "Average rollover limit amount"
    - name: "avg_irs_minimum_deductible"
      expr: AVG(CAST(irs_minimum_deductible AS DOUBLE))
      comment: "Average IRS minimum deductible requirement"
    - name: "avg_irs_oop_max"
      expr: AVG(CAST(irs_out_of_pocket_max AS DOUBLE))
      comment: "Average IRS out-of-pocket maximum requirement"
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution across all HSA/HRA configurations"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy benefit configuration metrics including formulary management, cost-sharing methods, specialty drug programs, and PBM contract performance"
  source: "`health_insurance_ecm`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Current status of the pharmacy benefit configuration"
    - name: "cost_sharing_method"
      expr: cost_sharing_method
      comment: "Method of cost sharing for pharmacy benefits"
    - name: "deductible_applicable"
      expr: deductible_applicable
      comment: "Whether deductible applies to pharmacy benefits"
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy is required"
    - name: "ninety_day_supply_allowed"
      expr: ninety_day_supply_allowed
      comment: "Whether 90-day supply is allowed"
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Whether specialty drugs are excluded"
    - name: "is_biologic_preferred"
      expr: is_biologic_preferred
      comment: "Whether biologics are preferred"
    - name: "is_biosimilar_preferred"
      expr: is_biosimilar_preferred
      comment: "Whether biosimilars are preferred"
    - name: "is_exempt_from_mlr"
      expr: is_exempt_from_mlr
      comment: "Whether exempt from Medical Loss Ratio requirements"
    - name: "specialty_pharmacy_network"
      expr: specialty_pharmacy_network
      comment: "Specialty pharmacy network designation"
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail pharmacy network type"
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail order pharmacy network type"
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the pharmacy benefit"
  measures:
    - name: "total_rx_benefit_configs"
      expr: COUNT(1)
      comment: "Total number of pharmacy benefit configurations"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average pharmacy deductible amount"
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average pharmacy coinsurance rate"
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average pharmacy out-of-pocket maximum"
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum coverage amount"
    - name: "avg_coverage_limit_per_rx"
      expr: AVG(CAST(coverage_limit_per_prescription AS DOUBLE))
      comment: "Average coverage limit per prescription"
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average coverage limit per year"
    - name: "step_therapy_required_count"
      expr: COUNT(CASE WHEN step_therapy_required = true THEN 1 END)
      comment: "Number of configurations requiring step therapy"
    - name: "ninety_day_supply_allowed_count"
      expr: COUNT(CASE WHEN ninety_day_supply_allowed = true THEN 1 END)
      comment: "Number of configurations allowing 90-day supply"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan service area metrics including geographic coverage, enrollment capacity, regulatory compliance, and market eligibility across states and counties"
  source: "`health_insurance_ecm`.`plan`.`plan_service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State where service area is defined"
    - name: "county"
      expr: county
      comment: "County within the service area"
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area"
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage in the service area"
    - name: "network_type"
      expr: network_type
      comment: "Network type for the service area"
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category in the service area"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the service area"
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market designation"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the service area is exclusive"
    - name: "is_medicaid_eligible"
      expr: is_medicaid_eligible
      comment: "Whether Medicaid eligible in this service area"
    - name: "is_medicare_eligible"
      expr: is_medicare_eligible
      comment: "Whether Medicare eligible in this service area"
    - name: "is_federal_funded"
      expr: is_federal_funded
      comment: "Whether federally funded"
    - name: "is_state_funded"
      expr: is_state_funded
      comment: "Whether state funded"
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Whether the service area is regulatory compliant"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status"
  measures:
    - name: "total_service_areas"
      expr: COUNT(1)
      comment: "Total number of plan service areas"
    - name: "distinct_states"
      expr: COUNT(DISTINCT state)
      comment: "Number of distinct states with service areas"
    - name: "distinct_counties"
      expr: COUNT(DISTINCT county)
      comment: "Number of distinct counties with service areas"
    - name: "medicaid_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicaid_eligible = true THEN 1 END)
      comment: "Number of Medicaid-eligible service areas"
    - name: "medicare_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicare_eligible = true THEN 1 END)
      comment: "Number of Medicare-eligible service areas"
    - name: "regulatory_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = true THEN 1 END)
      comment: "Number of regulatory-compliant service areas"
$$;