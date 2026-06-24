-- Metric views for domain: plan | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for health plan portfolio management: premium economics, cost-sharing design, enrollment windows, and plan composition by market segment, line of business, and geography."
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the health plan (Active, Terminated, Pending, etc.)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type classification (HMO, PPO, EPO, HDHP, etc.) for portfolio segmentation."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange) driving regulatory and financial treatment."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) for pricing and regulatory analysis."
    - name: "plan_state"
      expr: plan_state
      comment: "State in which the plan is offered, enabling geographic performance analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year trend analysis."
    - name: "metal_tier"
      expr: plan_category
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) or plan category for benefit richness segmentation."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (Tier 1, Tier 2, Broad) for network cost analysis."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification (ACA-compliant, grandfathered, transitional) for compliance reporting."
    - name: "plan_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Flag indicating whether the plan is eligible for marketplace/exchange distribution."
    - name: "plan_aca_compliant"
      expr: plan_aca_compliant
      comment: "Flag indicating ACA compliance status for regulatory reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of plan effective date for cohort and trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of plan termination for churn and attrition analysis."
  measures:
    - name: "total_active_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN health_plan_id END)
      comment: "Count of currently active health plans in the portfolio. Executives use this to track portfolio breadth and market coverage."
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total count of health plans across all statuses. Baseline portfolio size metric."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible across plans. Tracks benefit richness and member cost exposure trends."
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible across plans. Key indicator of family cost-sharing burden."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. Measures member financial protection level across the portfolio."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial exposure across plan designs."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average monthly premium amount across plans. Core revenue and pricing KPI for executive review."
    - name: "total_premium_revenue_potential"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Sum of premium amounts across all active plans. Proxy for total premium revenue potential in the portfolio."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay across plans. Tracks member access cost and benefit competitiveness."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay across plans. Monitors specialist access cost trends."
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans. Measures member cost-sharing design trends."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across plans. Critical for CMS risk adjustment revenue forecasting."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC risk score across plans. Drives risk adjustment revenue and actuarial pricing decisions."
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(CASE WHEN plan_marketplace_eligible = TRUE THEN health_plan_id END)
      comment: "Count of plans eligible for marketplace distribution. Tracks exchange market footprint."
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN plan_aca_compliant = TRUE THEN health_plan_id END)
      comment: "Count of ACA-compliant plans. Regulatory compliance portfolio metric."
    - name: "mlr_exempt_plan_count"
      expr: COUNT(CASE WHEN is_exempt_from_mlr = TRUE THEN health_plan_id END)
      comment: "Count of plans exempt from MLR requirements. Tracks regulatory exposure and rebate liability."
    - name: "distinct_states_offered"
      expr: COUNT(DISTINCT plan_state)
      comment: "Number of distinct states where plans are offered. Measures geographic market footprint."
    - name: "distinct_plan_types"
      expr: COUNT(DISTINCT plan_type)
      comment: "Number of distinct plan types in the portfolio. Tracks product diversity and market coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit design analytics: coverage richness, authorization requirements, cost-sharing levels, and regulatory classification across the benefit catalog."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit`"
  dimensions:
    - name: "benefit_status"
      expr: benefit_status
      comment: "Current status of the benefit (Active, Inactive, Pending) for portfolio management."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category (Preventive, Mental Health, Pharmacy, etc.) for coverage analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (In-Network, Out-of-Network, Both) for network benefit analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year benefit design trend analysis."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Whether prior authorization is required. Drives utilization management workload analysis."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization required (Prior Auth, Concurrent Review, etc.)."
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit classification for ACA compliance reporting."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the benefit for compliance and filing analysis."
    - name: "preventive_service_flag"
      expr: preventive_service_flag
      comment: "Flag for preventive services, which are typically covered at 100% under ACA."
    - name: "tier"
      expr: tier
      comment: "Benefit tier for tiered benefit design analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the benefit is mandated by state or federal regulation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month benefit became effective for trend and cohort analysis."
  measures:
    - name: "total_benefits"
      expr: COUNT(1)
      comment: "Total count of benefit records in the catalog. Baseline for benefit portfolio sizing."
    - name: "active_benefit_count"
      expr: COUNT(CASE WHEN benefit_status = 'Active' THEN benefit_id END)
      comment: "Count of currently active benefits. Tracks the live benefit catalog size."
    - name: "auth_required_benefit_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE THEN benefit_id END)
      comment: "Count of benefits requiring prior authorization. Drives UM workload planning and member friction analysis."
    - name: "auth_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN benefit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of benefits requiring prior authorization. Key metric for administrative burden and access management."
    - name: "preventive_benefit_count"
      expr: COUNT(CASE WHEN preventive_service_flag = TRUE THEN benefit_id END)
      comment: "Count of preventive service benefits. Tracks ACA preventive care mandate compliance."
    - name: "mandatory_benefit_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN benefit_id END)
      comment: "Count of mandated benefits. Tracks regulatory mandate compliance exposure."
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost-sharing amount across benefits. Measures member financial exposure in benefit design."
    - name: "avg_oop_max"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum across benefits. Tracks member financial protection levels."
    - name: "avg_moop_max"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average Medicare out-of-pocket maximum across benefits. Critical for Medicare plan design compliance."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value. Tracks coverage generosity and actuarial value trends."
    - name: "distinct_benefit_categories"
      expr: COUNT(DISTINCT benefit_category)
      comment: "Number of distinct benefit categories covered. Measures breadth of coverage portfolio."
    - name: "exempt_benefit_count"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN benefit_id END)
      comment: "Count of benefits exempt from standard rules. Tracks regulatory exemption exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package design KPIs: actuarial value, cost-sharing structure, metal tier distribution, and package portfolio health for plan design and pricing decisions."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package (Active, Inactive, Pending)."
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) for actuarial value segmentation."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO) associated with the package."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (Narrow, Broad, Tiered) for network design analysis."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required for this package."
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Whether generic drug substitution is required, impacting pharmacy cost management."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the benefit package became effective for trend analysis."
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(1)
      comment: "Total count of benefit packages. Baseline portfolio sizing metric."
    - name: "active_package_count"
      expr: COUNT(CASE WHEN benefit_package_status = 'Active' THEN benefit_package_id END)
      comment: "Count of currently active benefit packages. Tracks live product portfolio."
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across packages. Core metric for ACA metal tier compliance and benefit richness."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible across benefit packages. Tracks member cost exposure trends."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible across benefit packages. Monitors family financial burden in plan design."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. Measures member financial protection level."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial exposure."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay. Measures member access cost and benefit competitiveness."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay across packages. Tracks specialist access cost trends."
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay. Critical for pharmacy benefit cost management."
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay. Tracks pharmacy benefit generosity and generic utilization incentives."
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay. Monitors brand drug cost-sharing design."
    - name: "avg_coinsurance_inpatient"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate. Tracks member inpatient cost exposure."
    - name: "avg_coinsurance_outpatient"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate. Monitors outpatient cost-sharing design."
    - name: "prior_auth_required_package_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN benefit_package_id END)
      comment: "Count of packages requiring prior authorization. Drives UM workload and member access planning."
    - name: "distinct_metal_tiers"
      expr: COUNT(DISTINCT metal_tier)
      comment: "Number of distinct metal tiers offered. Tracks ACA product portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate analytics: base rate levels, age-rated premiums, tobacco surcharges, and rate distribution by market segment, rating area, and plan year for pricing and actuarial decisions."
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) for rate segmentation."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year rate trend analysis."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code for regional rate analysis."
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Employee Only, Employee + Spouse, Family, etc.) for tier-based rate analysis."
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Tobacco use indicator for surcharge analysis and ACA compliance."
    - name: "is_tobacco_surcharge_applicable"
      expr: is_tobacco_surcharge_applicable
      comment: "Whether tobacco surcharge applies to this rate record."
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory filing (SERFF, HPMS, etc.) for compliance tracking."
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation for rate classification and reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the rate became effective for trend and seasonality analysis."
    - name: "underwriting_class_code"
      expr: underwriting_class_code
      comment: "Underwriting class for risk-based rate segmentation."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total count of rate records. Baseline for rate portfolio sizing and filing completeness."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate. Core pricing KPI for actuarial and executive review."
    - name: "min_base_rate"
      expr: MIN(CAST(base_rate AS DOUBLE))
      comment: "Minimum base rate in the portfolio. Tracks competitive floor pricing."
    - name: "max_base_rate"
      expr: MAX(CAST(base_rate AS DOUBLE))
      comment: "Maximum base rate in the portfolio. Tracks premium ceiling and affordability exposure."
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium. Measures age-band pricing impact on member affordability."
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium. Tracks family coverage affordability and employer contribution planning."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount. Monitors wellness incentive program financial impact."
    - name: "tobacco_surcharge_applicable_count"
      expr: COUNT(CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN rate_id END)
      comment: "Count of rate records with tobacco surcharge applicable. Tracks surcharge program scope."
    - name: "distinct_rating_areas"
      expr: COUNT(DISTINCT rating_area_code)
      comment: "Number of distinct rating areas covered. Measures geographic pricing footprint."
    - name: "rate_spread"
      expr: COUNT(1)
      comment: "Spread between maximum and minimum base rates. Measures pricing variability and risk segmentation breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule analytics: deductible levels, copay and coinsurance design, OOP maximums, and rule coverage across benefit categories and network types for benefit design governance."
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule (Deductible, Copay, Coinsurance, OOP Max) for rule classification."
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network) the rule applies to."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier the rule applies to for tiered benefit design analysis."
    - name: "applies_to_service_category"
      expr: applies_to_service_category
      comment: "Service category the rule applies to for coverage analysis."
    - name: "hsa_compatible"
      expr: hsa_compatible
      comment: "Whether the rule is compatible with HSA requirements. Critical for HDHP/HSA plan compliance."
    - name: "after_deductible"
      expr: after_deductible
      comment: "Whether cost-sharing applies after deductible is met."
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Whether this is the default cost-sharing rule for the plan."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the rule for compliance reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rule became effective for trend analysis."
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(1)
      comment: "Total count of cost-sharing rules. Baseline for rule catalog governance."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across rules. Tracks member cost exposure and HDHP design trends."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount across rules. Measures member point-of-service cost burden."
    - name: "avg_copay_out_of_network"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay. Tracks OON cost deterrence design."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate across rules. Monitors member cost-sharing percentage trends."
    - name: "avg_coinsurance_out_of_network"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate. Tracks OON financial deterrence levels."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across rules. Measures member financial protection."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial exposure in benefit design."
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount. Tracks coverage caps and actuarial liability exposure."
    - name: "hsa_compatible_rule_count"
      expr: COUNT(CASE WHEN hsa_compatible = TRUE THEN cost_share_rule_id END)
      comment: "Count of HSA-compatible cost-sharing rules. Tracks HDHP/HSA product compliance."
    - name: "hsa_compatible_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hsa_compatible = TRUE THEN cost_share_rule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cost-sharing rules that are HSA-compatible. Monitors HDHP product portfolio share."
    - name: "avg_accumulator_threshold"
      expr: AVG(CAST(accumulator_threshold AS DOUBLE))
      comment: "Average accumulator threshold across rules. Tracks benefit limit design and actuarial exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service area coverage analytics: geographic footprint, regulatory compliance, market eligibility, and enrollment capacity across states, counties, and plan years."
  source: "`vibe_health_insurance_v1`.`plan`.`plan_service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State of the service area for geographic analysis."
    - name: "county"
      expr: county
      comment: "County within the service area for sub-state geographic analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year service area trend analysis."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (County, ZIP, State) for geographic granularity analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type associated with the service area."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the service area record."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market type (Federal, State-Based) for marketplace analysis."
    - name: "is_medicaid_eligible"
      expr: is_medicaid_eligible
      comment: "Whether the service area is eligible for Medicaid plans."
    - name: "is_medicare_eligible"
      expr: is_medicare_eligible
      comment: "Whether the service area is eligible for Medicare plans."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Whether the service area meets regulatory requirements."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the service area filing."
  measures:
    - name: "total_service_areas"
      expr: COUNT(1)
      comment: "Total count of service area records. Baseline for geographic coverage portfolio."
    - name: "distinct_states_covered"
      expr: COUNT(DISTINCT state)
      comment: "Number of distinct states covered. Measures geographic market footprint for executive reporting."
    - name: "distinct_counties_covered"
      expr: COUNT(DISTINCT county)
      comment: "Number of distinct counties covered. Tracks sub-state geographic penetration."
    - name: "regulatory_compliant_area_count"
      expr: COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN plan_service_area_id END)
      comment: "Count of service areas meeting regulatory requirements. Tracks compliance posture."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN plan_service_area_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service areas that are regulatory compliant. Critical compliance KPI for state filings."
    - name: "medicaid_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicaid_eligible = TRUE THEN plan_service_area_id END)
      comment: "Count of service areas eligible for Medicaid plans. Tracks government program geographic footprint."
    - name: "medicare_eligible_area_count"
      expr: COUNT(CASE WHEN is_medicare_eligible = TRUE THEN plan_service_area_id END)
      comment: "Count of service areas eligible for Medicare plans. Tracks Medicare market geographic coverage."
    - name: "exchange_market_area_count"
      expr: COUNT(CASE WHEN exchange_market IS NOT NULL AND exchange_market != '' THEN plan_service_area_id END)
      comment: "Count of service areas participating in exchange markets. Tracks marketplace distribution footprint."
    - name: "exclusive_area_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN plan_service_area_id END)
      comment: "Count of exclusive service areas. Tracks geographic exclusivity arrangements."
    - name: "regulatory_approved_area_count"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN plan_service_area_id END)
      comment: "Count of service areas with regulatory approval. Tracks filing approval pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission analytics: filing volumes, approval rates, rejection rates, fee economics, and submission cycle times for compliance and regulatory affairs management."
  source: "`vibe_health_insurance_v1`.`plan`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission (Submitted, Approved, Rejected, Withdrawn)."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (Rate Filing, Form Filing, Network Filing, etc.)."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body receiving the submission (State DOI, CMS, HPMS, etc.)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the submission for product-level analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the submission for annual filing cycle analysis."
    - name: "is_annual_filing"
      expr: is_annual_filing
      comment: "Whether this is an annual filing for cycle management."
    - name: "submitter_role"
      expr: submitter_role
      comment: "Role of the submitter for workflow and accountability analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission for filing volume trend analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of approval for cycle time and throughput analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total count of regulatory submissions. Baseline for filing volume and compliance workload."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN submission_id END)
      comment: "Count of approved submissions. Tracks regulatory approval success rate."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN submission_id END)
      comment: "Count of rejected submissions. Tracks filing quality and rework burden."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Approved' THEN submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions approved. Key regulatory affairs quality KPI."
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Rejected' THEN submission_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected. Tracks filing quality and compliance risk."
    - name: "withdrawn_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Withdrawn' THEN submission_id END)
      comment: "Count of withdrawn submissions. Tracks strategic filing decisions and plan changes."
    - name: "total_filing_fee_gross"
      expr: SUM(CAST(filing_fee_gross AS DOUBLE))
      comment: "Total gross filing fees paid. Tracks regulatory compliance cost."
    - name: "total_filing_fee_net"
      expr: SUM(CAST(filing_fee_net AS DOUBLE))
      comment: "Total net filing fees after adjustments. Measures actual regulatory cost outlay."
    - name: "avg_filing_fee_net"
      expr: AVG(CAST(filing_fee_net AS DOUBLE))
      comment: "Average net filing fee per submission. Benchmarks regulatory cost per filing."
    - name: "total_filing_fee_adjustment"
      expr: SUM(CAST(filing_fee_adjustment AS DOUBLE))
      comment: "Total filing fee adjustments. Tracks fee reconciliation and dispute amounts."
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies filed with. Measures regulatory complexity and compliance footprint."
    - name: "overdue_submission_count"
      expr: COUNT(CASE WHEN submission_status NOT IN ('Approved','Withdrawn') AND regulatory_submission_deadline < CURRENT_DATE() THEN submission_id END)
      comment: "Count of submissions past their regulatory deadline. Critical compliance risk indicator requiring immediate action."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan amendment analytics: amendment volumes, regulatory approval rates, financial impact, member notification compliance, and amendment cycle management for plan governance."
  source: "`vibe_health_insurance_v1`.`plan`.`plan_amendment`"
  dimensions:
    - name: "plan_amendment_status"
      expr: plan_amendment_status
      comment: "Current status of the plan amendment (Pending, Approved, Rejected, Effective)."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Benefit Change, Network Change, Rate Change, etc.) for impact analysis."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the amendment filing."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the amendment has compliance implications."
    - name: "member_notification_required"
      expr: member_notification_required
      comment: "Whether member notification is required for this amendment."
    - name: "triggers_sbc_generation"
      expr: triggers_sbc_generation
      comment: "Whether the amendment triggers a new SBC document generation."
    - name: "effective_year"
      expr: effective_year
      comment: "Effective year of the amendment for annual cycle analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment becomes effective for trend analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment for root cause and pattern analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total count of plan amendments. Baseline for plan change volume and governance workload."
    - name: "approved_amendment_count"
      expr: COUNT(CASE WHEN plan_amendment_status = 'Approved' THEN plan_amendment_id END)
      comment: "Count of approved amendments. Tracks amendment approval throughput."
    - name: "pending_amendment_count"
      expr: COUNT(CASE WHEN plan_amendment_status = 'Pending' THEN plan_amendment_id END)
      comment: "Count of pending amendments. Tracks backlog and governance workload."
    - name: "regulatory_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN plan_amendment_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments receiving regulatory approval. Key compliance quality metric."
    - name: "member_notification_required_count"
      expr: COUNT(CASE WHEN member_notification_required = TRUE THEN plan_amendment_id END)
      comment: "Count of amendments requiring member notification. Tracks member communication compliance obligations."
    - name: "sbc_triggering_amendment_count"
      expr: COUNT(CASE WHEN triggers_sbc_generation = TRUE THEN plan_amendment_id END)
      comment: "Count of amendments triggering SBC regeneration. Drives document production workload planning."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Total estimated cost impact of amendments. Critical financial planning metric for actuarial and finance teams."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Average estimated cost impact per amendment. Benchmarks amendment financial materiality."
    - name: "total_estimated_member_cost_impact"
      expr: SUM(CAST(impact_estimated_member_cost AS DOUBLE))
      comment: "Total estimated member cost impact of amendments. Tracks member affordability implications of plan changes."
    - name: "total_estimated_provider_cost_impact"
      expr: SUM(CAST(impact_estimated_provider_cost AS DOUBLE))
      comment: "Total estimated provider cost impact of amendments. Tracks provider reimbursement implications."
    - name: "compliance_flagged_amendment_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN plan_amendment_id END)
      comment: "Count of amendments with compliance flags. Tracks regulatory risk exposure from plan changes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer plan offering analytics: contribution economics, offering portfolio by type and status, and enrollment window management for employer group sales and retention."
  source: "`vibe_health_insurance_v1`.`plan`.`offering`"
  dimensions:
    - name: "offering_status"
      expr: offering_status
      comment: "Current status of the offering (Active, Inactive, Pending) for portfolio management."
    - name: "offering_type"
      expr: offering_type
      comment: "Type of offering (Medical, Dental, Vision, etc.) for product line analysis."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Employer contribution type (Fixed, Percentage, Defined Contribution) for benefits strategy analysis."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (Employee Only, Employee+Spouse, Family) for tier-based analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the offering became effective for trend analysis."
    - name: "open_enrollment_start_month"
      expr: DATE_TRUNC('MONTH', open_enrollment_start_date)
      comment: "Month open enrollment begins for enrollment cycle planning."
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total count of plan offerings. Baseline for employer group product portfolio sizing."
    - name: "active_offering_count"
      expr: COUNT(CASE WHEN offering_status = 'Active' THEN offering_id END)
      comment: "Count of currently active offerings. Tracks live employer group product portfolio."
    - name: "distinct_employer_groups"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups with plan offerings. Measures employer group market penetration."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering. Tracks employer benefit generosity and cost trends."
    - name: "total_employer_contribution_amount"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount across offerings. Measures total employer benefit spend commitment."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount. Tracks employee premium burden and affordability."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount. Monitors family coverage affordability."
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage. Benchmarks employer benefit generosity across groups."
    - name: "distinct_offering_types"
      expr: COUNT(DISTINCT offering_type)
      comment: "Number of distinct offering types. Measures product line breadth for employer groups."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_regulatory_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan regulatory obligation compliance analytics: compliance rates, overdue obligations, filing status, and regulatory body coverage for compliance governance and risk management."
  source: "`vibe_health_insurance_v1`.`plan`.`plan_regulatory_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (Filing, Reporting, Attestation, etc.) for compliance categorization."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body (CMS, State DOI, NCQA, etc.) imposing the obligation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, In Progress, Overdue)."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance flag for quick compliance posture analysis."
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for fulfilling the obligation for accountability tracking."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the obligation is due for deadline management."
    - name: "next_due_date_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month of the next due date for forward-looking compliance planning."
  measures:
    - name: "total_regulatory_obligations"
      expr: COUNT(1)
      comment: "Total count of plan regulatory obligations. Baseline for compliance workload and risk exposure."
    - name: "compliant_obligation_count"
      expr: COUNT(CASE WHEN is_compliant = TRUE THEN plan_regulatory_obligation_id END)
      comment: "Count of obligations currently in compliance. Tracks compliance posture."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN is_compliant = FALSE THEN plan_regulatory_obligation_id END)
      comment: "Count of non-compliant obligations. Critical risk indicator requiring immediate remediation."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliant = TRUE THEN plan_regulatory_obligation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory obligations in compliance. Top-level compliance health KPI for executive reporting."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Overdue' THEN plan_regulatory_obligation_id END)
      comment: "Count of overdue regulatory obligations. Tracks regulatory penalty and enforcement risk."
    - name: "distinct_regulatory_bodies"
      expr: COUNT(DISTINCT regulatory_body)
      comment: "Number of distinct regulatory bodies with obligations. Measures regulatory complexity and compliance footprint."
    - name: "obligations_due_this_month"
      expr: COUNT(CASE WHEN DATE_TRUNC('MONTH', due_date) = DATE_TRUNC('MONTH', CURRENT_DATE()) THEN plan_regulatory_obligation_id END)
      comment: "Count of obligations due in the current month. Drives near-term compliance workload prioritization."
    - name: "satisfied_obligation_count"
      expr: COUNT(CASE WHEN satisfied_date IS NOT NULL THEN plan_regulatory_obligation_id END)
      comment: "Count of obligations that have been satisfied. Tracks compliance completion throughput."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_hsa_hra_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSA/HRA configuration analytics: contribution limits, employer contribution economics, rollover policies, and IRS compliance for consumer-directed health account program management."
  source: "`vibe_health_insurance_v1`.`plan`.`hsa_hra_config`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Account type (HSA, HRA, FSA) for consumer-directed health account segmentation."
    - name: "hsa_hra_config_status"
      expr: hsa_hra_config_status
      comment: "Current status of the HSA/HRA configuration (Active, Inactive, Pending)."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution frequency (Monthly, Annual, Per-Paycheck) for cash flow analysis."
    - name: "contribution_method"
      expr: contribution_method
      comment: "Contribution method (Payroll Deduction, Direct Deposit, etc.) for administration analysis."
    - name: "rollover_allowed"
      expr: rollover_allowed
      comment: "Whether rollover of unused funds is allowed. Key plan design feature for member retention."
    - name: "catch_up_contribution_eligible"
      expr: catch_up_contribution_eligible
      comment: "Whether catch-up contributions are allowed (age 55+ for HSA)."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the configuration meets IRS regulatory requirements."
    - name: "plan_year_start_month"
      expr: DATE_TRUNC('MONTH', plan_year_start_date)
      comment: "Month the plan year starts for annual cycle analysis."
  measures:
    - name: "total_hsa_hra_configs"
      expr: COUNT(1)
      comment: "Total count of HSA/HRA configurations. Baseline for consumer-directed health account program portfolio."
    - name: "active_config_count"
      expr: COUNT(CASE WHEN hsa_hra_config_status = 'Active' THEN hsa_hra_config_id END)
      comment: "Count of active HSA/HRA configurations. Tracks live consumer-directed health account programs."
    - name: "avg_contribution_limit_amount"
      expr: AVG(CAST(contribution_limit_amount AS DOUBLE))
      comment: "Average contribution limit amount. Benchmarks against IRS limits for compliance monitoring."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount. Tracks employer benefit generosity in consumer-directed accounts."
    - name: "total_employer_contribution_amount"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount across all configurations. Measures total employer HSA/HRA spend commitment."
    - name: "avg_employee_contribution_limit"
      expr: AVG(CAST(employee_contribution_limit AS DOUBLE))
      comment: "Average employee contribution limit. Tracks member savings capacity in consumer-directed accounts."
    - name: "avg_rollover_limit_amount"
      expr: AVG(CAST(rollover_limit_amount AS DOUBLE))
      comment: "Average rollover limit amount. Monitors fund carryover generosity across programs."
    - name: "avg_irs_minimum_deductible"
      expr: AVG(CAST(irs_minimum_deductible AS DOUBLE))
      comment: "Average IRS minimum deductible across configurations. Tracks HDHP compliance with IRS thresholds."
    - name: "avg_irs_oop_max"
      expr: AVG(CAST(irs_out_of_pocket_max AS DOUBLE))
      comment: "Average IRS out-of-pocket maximum. Monitors HDHP compliance with IRS OOP limits."
    - name: "rollover_allowed_count"
      expr: COUNT(CASE WHEN rollover_allowed = TRUE THEN hsa_hra_config_id END)
      comment: "Count of configurations allowing rollover. Tracks member-friendly fund carryover program scope."
    - name: "regulatory_compliant_config_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN hsa_hra_config_id END)
      comment: "Count of IRS-compliant configurations. Critical compliance metric for consumer-directed health accounts."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN hsa_hra_config_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of HSA/HRA configurations meeting IRS regulatory requirements. Top-level compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_sbc_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Summary of Benefits and Coverage (SBC) document analytics: document currency, regulatory submission status, revision cycles, and document portfolio health for ACA compliance management."
  source: "`vibe_health_insurance_v1`.`plan`.`sbc_document`"
  dimensions:
    - name: "sbc_document_status"
      expr: sbc_document_status
      comment: "Current status of the SBC document (Draft, Approved, Published, Expired)."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Regulatory submission status of the SBC (Submitted, Approved, Pending)."
    - name: "document_type"
      expr: document_type
      comment: "Type of document for classification and routing."
    - name: "document_category"
      expr: document_category
      comment: "Document category for portfolio organization."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year the SBC covers for annual cycle management."
    - name: "language"
      expr: language
      comment: "Language of the SBC document for member accessibility compliance."
    - name: "is_current"
      expr: is_current
      comment: "Whether this is the current version of the SBC. Critical for member disclosure compliance."
    - name: "format"
      expr: format
      comment: "Document format (PDF, HTML, etc.) for distribution channel analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the SBC becomes effective for compliance timeline tracking."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of regulatory submission for filing cycle analysis."
  measures:
    - name: "total_sbc_documents"
      expr: COUNT(1)
      comment: "Total count of SBC documents. Baseline for document portfolio and compliance coverage."
    - name: "current_sbc_count"
      expr: COUNT(CASE WHEN is_current = TRUE THEN sbc_document_id END)
      comment: "Count of current SBC documents. Tracks active member disclosure compliance."
    - name: "approved_sbc_count"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'Approved' THEN sbc_document_id END)
      comment: "Count of SBCs with regulatory approval. Tracks filing compliance status."
    - name: "pending_submission_count"
      expr: COUNT(CASE WHEN regulatory_submission_status = 'Pending' THEN sbc_document_id END)
      comment: "Count of SBCs pending regulatory submission. Tracks compliance backlog."
    - name: "regulatory_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status = 'Approved' THEN sbc_document_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SBC documents with regulatory approval. Key ACA compliance KPI."
    - name: "distinct_languages"
      expr: COUNT(DISTINCT language)
      comment: "Number of distinct languages SBCs are available in. Tracks member accessibility and language access compliance."
    - name: "avg_document_size_bytes"
      expr: AVG(CAST(document_size_bytes AS DOUBLE))
      comment: "Average SBC document size in bytes. Monitors document complexity and distribution cost."
    - name: "total_document_size_bytes"
      expr: SUM(CAST(document_size_bytes AS DOUBLE))
      comment: "Total SBC document storage size. Tracks document management infrastructure requirements."
    - name: "expired_sbc_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE() AND is_current = FALSE THEN sbc_document_id END)
      comment: "Count of expired SBC documents. Tracks document lifecycle hygiene and archival needs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_year`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan year lifecycle analytics: budget allocation, enrollment window management, regulatory filing requirements, and plan year portfolio health for annual planning and compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`year`"
  dimensions:
    - name: "year_status"
      expr: year_status
      comment: "Current status of the plan year (Active, Closed, Pending, Future)."
    - name: "plan_year_type"
      expr: plan_year_type
      comment: "Type of plan year (Calendar, Non-Calendar, Fiscal) for cycle management."
    - name: "plan_year_market_segment"
      expr: plan_year_market_segment
      comment: "Market segment for the plan year for segmented performance analysis."
    - name: "plan_year_state"
      expr: plan_year_state
      comment: "State associated with the plan year for geographic analysis."
    - name: "plan_year_coverage_type"
      expr: plan_year_coverage_type
      comment: "Coverage type for the plan year for product line analysis."
    - name: "aca_compliance_indicator"
      expr: aca_compliance_indicator
      comment: "Whether the plan year is ACA compliant. Critical regulatory compliance flag."
    - name: "regulatory_filing_required"
      expr: regulatory_filing_required
      comment: "Whether regulatory filing is required for this plan year."
    - name: "plan_year_regulatory_classification"
      expr: plan_year_regulatory_classification
      comment: "Regulatory classification of the plan year for compliance reporting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the plan year starts for cycle analysis."
    - name: "open_enrollment_start_month"
      expr: DATE_TRUNC('MONTH', open_enrollment_start_date)
      comment: "Month open enrollment begins for enrollment planning."
  measures:
    - name: "total_plan_years"
      expr: COUNT(1)
      comment: "Total count of plan year records. Baseline for annual planning portfolio."
    - name: "active_plan_year_count"
      expr: COUNT(CASE WHEN year_status = 'Active' THEN year_id END)
      comment: "Count of currently active plan years. Tracks live plan year portfolio."
    - name: "total_plan_year_budget"
      expr: SUM(CAST(plan_year_budget_amount AS DOUBLE))
      comment: "Total budget allocated across plan years. Core financial planning metric for executive review."
    - name: "avg_plan_year_budget"
      expr: AVG(CAST(plan_year_budget_amount AS DOUBLE))
      comment: "Average budget per plan year. Benchmarks annual financial commitment per plan."
    - name: "avg_plan_year_premium_rate"
      expr: AVG(CAST(plan_year_premium_rate AS DOUBLE))
      comment: "Average premium rate for the plan year. Tracks year-over-year premium trend for pricing decisions."
    - name: "total_plan_year_premium_rate"
      expr: SUM(CAST(plan_year_premium_rate AS DOUBLE))
      comment: "Sum of plan year premium rates. Proxy for total premium revenue base across plan years."
    - name: "aca_compliant_year_count"
      expr: COUNT(CASE WHEN aca_compliance_indicator = TRUE THEN year_id END)
      comment: "Count of ACA-compliant plan years. Tracks regulatory compliance across the annual portfolio."
    - name: "regulatory_filing_required_count"
      expr: COUNT(CASE WHEN regulatory_filing_required = TRUE THEN year_id END)
      comment: "Count of plan years requiring regulatory filing. Drives compliance workload planning."
    - name: "avg_grace_period_days"
      expr: AVG(CAST(grace_period_days AS DOUBLE))
      comment: "Average grace period days across plan years. Tracks member payment flexibility and premium collection risk."
    - name: "avg_run_out_period_days"
      expr: AVG(CAST(run_out_period_days AS DOUBLE))
      comment: "Average run-out period days. Tracks claims liability tail exposure after plan year end."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_network_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network configuration analytics: network coverage, out-of-network benefit design, adequacy metrics, and network portfolio health for network strategy and regulatory compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`network_config`"
  dimensions:
    - name: "network_config_status"
      expr: network_config_status
      comment: "Current status of the network configuration (Active, Inactive, Pending)."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation for tiered network design analysis."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (Narrow, Broad, Tiered, Exclusive) for network strategy analysis."
    - name: "network_state"
      expr: network_state
      comment: "State of the network configuration for geographic analysis."
    - name: "network_coverage_type"
      expr: network_coverage_type
      comment: "Coverage type of the network for product line analysis."
    - name: "access_type"
      expr: access_type
      comment: "Access type (Open, Gated, Referral Required) for member access analysis."
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Whether out-of-network coverage is provided. Key benefit design feature."
    - name: "network_exclusion_flag"
      expr: network_exclusion_flag
      comment: "Whether network exclusions apply. Tracks network restriction scope."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the network configuration became effective for trend analysis."
  measures:
    - name: "total_network_configs"
      expr: COUNT(1)
      comment: "Total count of network configurations. Baseline for network portfolio sizing."
    - name: "active_network_config_count"
      expr: COUNT(CASE WHEN network_config_status = 'Active' THEN network_config_id END)
      comment: "Count of active network configurations. Tracks live network portfolio."
    - name: "out_of_network_coverage_count"
      expr: COUNT(CASE WHEN out_of_network_coverage_flag = TRUE THEN network_config_id END)
      comment: "Count of configurations providing out-of-network coverage. Tracks OON benefit availability."
    - name: "out_of_network_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_network_coverage_flag = TRUE THEN network_config_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of network configurations with OON coverage. Measures benefit flexibility across the portfolio."
    - name: "avg_out_of_network_coinsurance_pct"
      expr: AVG(CAST(out_of_network_coinsurance_pct AS DOUBLE))
      comment: "Average out-of-network coinsurance percentage. Tracks OON cost deterrence design."
    - name: "avg_out_of_network_copay_amount"
      expr: AVG(CAST(out_of_network_copay_amount AS DOUBLE))
      comment: "Average out-of-network copay amount. Monitors OON member cost burden."
    - name: "network_exclusion_count"
      expr: COUNT(CASE WHEN network_exclusion_flag = TRUE THEN network_config_id END)
      comment: "Count of configurations with network exclusions. Tracks network restriction scope and member access risk."
    - name: "distinct_states_configured"
      expr: COUNT(DISTINCT network_state)
      comment: "Number of distinct states with network configurations. Measures geographic network footprint."
    - name: "distinct_network_tiers"
      expr: COUNT(DISTINCT network_tier)
      comment: "Number of distinct network tiers configured. Tracks tiered network design complexity."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy benefit configuration analytics: coverage limits, cost-sharing design, formulary management, and specialty drug program economics for pharmacy benefit strategy."
  source: "`vibe_health_insurance_v1`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Current status of the Rx benefit configuration (Active, Inactive, Pending)."
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail pharmacy network type for network design analysis."
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail order pharmacy network type for mail order program analysis."
    - name: "specialty_pharmacy_network"
      expr: specialty_pharmacy_network
      comment: "Specialty pharmacy network designation for specialty drug management."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the Rx benefit for compliance reporting."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy is required. Tracks utilization management program scope."
    - name: "deductible_applicable"
      expr: deductible_applicable
      comment: "Whether deductible applies to Rx benefits. Tracks integrated vs. separate deductible design."
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Whether specialty drugs are excluded from the benefit."
    - name: "ninety_day_supply_allowed"
      expr: ninety_day_supply_allowed
      comment: "Whether 90-day supply is allowed. Tracks mail order and adherence program design."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the Rx benefit configuration became effective for trend analysis."
  measures:
    - name: "total_rx_benefit_configs"
      expr: COUNT(1)
      comment: "Total count of Rx benefit configurations. Baseline for pharmacy benefit portfolio sizing."
    - name: "active_rx_config_count"
      expr: COUNT(CASE WHEN rx_benefit_config_status = 'Active' THEN rx_benefit_config_id END)
      comment: "Count of active Rx benefit configurations. Tracks live pharmacy benefit portfolio."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average Rx coinsurance rate. Tracks member pharmacy cost-sharing burden."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average Rx deductible amount. Monitors pharmacy benefit cost exposure."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average Rx out-of-pocket maximum. Tracks member pharmacy financial protection."
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average annual coverage limit for Rx benefits. Monitors pharmacy benefit cap exposure."
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum coverage amount for Rx benefits. Tracks pharmacy benefit generosity."
    - name: "step_therapy_required_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN rx_benefit_config_id END)
      comment: "Count of configurations requiring step therapy. Tracks pharmacy UM program scope and cost management."
    - name: "step_therapy_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN step_therapy_required = TRUE THEN rx_benefit_config_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Rx configurations requiring step therapy. Measures pharmacy cost management program penetration."
    - name: "specialty_drug_excluded_count"
      expr: COUNT(CASE WHEN is_specialty_drug_excluded = TRUE THEN rx_benefit_config_id END)
      comment: "Count of configurations excluding specialty drugs. Tracks specialty drug benefit exposure management."
    - name: "ninety_day_supply_allowed_count"
      expr: COUNT(CASE WHEN ninety_day_supply_allowed = TRUE THEN rx_benefit_config_id END)
      comment: "Count of configurations allowing 90-day supply. Tracks mail order and medication adherence program scope."
    - name: "mlr_exempt_rx_config_count"
      expr: COUNT(CASE WHEN is_exempt_from_mlr = TRUE THEN rx_benefit_config_id END)
      comment: "Count of Rx configurations exempt from MLR. Tracks MLR rebate liability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_crosswalk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan crosswalk analytics: plan transition volumes, mandatory crosswalk rates, member notification compliance, and regulatory submission status for plan year transition management."
  source: "`vibe_health_insurance_v1`.`plan`.`crosswalk`"
  dimensions:
    - name: "crosswalk_status"
      expr: crosswalk_status
      comment: "Current status of the crosswalk (Active, Pending, Completed, Cancelled)."
    - name: "crosswalk_type"
      expr: crosswalk_type
      comment: "Type of crosswalk (Auto-Renewal, Plan Discontinuation, Market Transition) for transition analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the crosswalk for annual transition cycle analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the crosswalk for regional transition analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the crosswalk is mandatory (regulatory requirement vs. voluntary)."
    - name: "member_notification_required"
      expr: member_notification_required
      comment: "Whether member notification is required for this crosswalk."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Whether regulatory submission is required for this crosswalk."
    - name: "notification_method"
      expr: notification_method
      comment: "Method of member notification (Mail, Email, Portal) for communication analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the crosswalk becomes effective for transition planning."
  measures:
    - name: "total_crosswalks"
      expr: COUNT(1)
      comment: "Total count of plan crosswalks. Baseline for plan transition volume and member impact."
    - name: "active_crosswalk_count"
      expr: COUNT(CASE WHEN crosswalk_status = 'Active' THEN crosswalk_id END)
      comment: "Count of active crosswalks. Tracks current plan transition activity."
    - name: "mandatory_crosswalk_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN crosswalk_id END)
      comment: "Count of mandatory crosswalks. Tracks regulatory-driven plan transitions."
    - name: "mandatory_crosswalk_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE THEN crosswalk_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of crosswalks that are mandatory. Measures regulatory-driven transition burden."
    - name: "member_notification_required_count"
      expr: COUNT(CASE WHEN member_notification_required = TRUE THEN crosswalk_id END)
      comment: "Count of crosswalks requiring member notification. Drives member communication workload planning."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_date IS NOT NULL THEN crosswalk_id END)
      comment: "Count of crosswalks where member notification has been sent. Tracks notification compliance completion."
    - name: "notification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN notification_sent_date IS NOT NULL THEN crosswalk_id END) / NULLIF(COUNT(CASE WHEN member_notification_required = TRUE THEN crosswalk_id END), 0), 2)
      comment: "Percentage of required notifications that have been sent. Critical member communication compliance KPI."
    - name: "regulatory_submission_required_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN crosswalk_id END)
      comment: "Count of crosswalks requiring regulatory submission. Tracks compliance filing workload."
    - name: "distinct_plan_years"
      expr: COUNT(DISTINCT plan_year)
      comment: "Number of distinct plan years with crosswalks. Tracks transition activity across annual cycles."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan-provider contract analytics: in-network contract coverage, reimbursement method distribution, contract status, and provider relationship management for network adequacy and cost management."
  source: "`vibe_health_insurance_v1`.`plan`.`plan_provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the plan-provider contract (Active, Terminated, Pending, Expired)."
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Reimbursement method (FFS, Capitation, DRG, Per Diem) for payment model analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of provider relationship (Primary, Specialist, Facility, Ancillary) for network composition analysis."
    - name: "is_in_network"
      expr: is_in_network
      comment: "Whether the provider is in-network under this contract. Core network adequacy metric."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for trend analysis."
    - name: "termination_date_month"
      expr: DATE_TRUNC('MONTH', termination_date)
      comment: "Month of contract termination for network attrition analysis."
  measures:
    - name: "total_provider_contracts"
      expr: COUNT(1)
      comment: "Total count of plan-provider contracts. Baseline for network contract portfolio sizing."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN plan_provider_contract_id END)
      comment: "Count of active provider contracts. Tracks live network contract portfolio."
    - name: "in_network_contract_count"
      expr: COUNT(CASE WHEN is_in_network = TRUE THEN plan_provider_contract_id END)
      comment: "Count of in-network provider contracts. Core network adequacy metric."
    - name: "in_network_contract_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_in_network = TRUE THEN plan_provider_contract_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provider contracts that are in-network. Tracks network adequacy and member access."
    - name: "terminated_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Terminated' THEN plan_provider_contract_id END)
      comment: "Count of terminated provider contracts. Tracks network attrition and adequacy risk."
    - name: "distinct_reimbursement_methods"
      expr: COUNT(DISTINCT reimbursement_method)
      comment: "Number of distinct reimbursement methods in use. Tracks payment model diversity and value-based care adoption."
    - name: "distinct_relationship_types"
      expr: COUNT(DISTINCT relationship_type)
      comment: "Number of distinct provider relationship types. Measures network composition breadth."
    - name: "pending_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Pending' THEN plan_provider_contract_id END)
      comment: "Count of pending provider contracts. Tracks network expansion pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_program_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program coverage analytics: coverage status, cost-sharing design for care programs, prior authorization requirements, and coverage portfolio health for care management integration."
  source: "`vibe_health_insurance_v1`.`plan`.`program_coverage`"
  dimensions:
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of the program coverage (Active, Inactive, Pending, Terminated)."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (Medical, Behavioral, Pharmacy, etc.) for program analysis."
    - name: "coverage_category"
      expr: coverage_category
      comment: "Coverage category for program classification and reporting."
    - name: "coverage_level"
      expr: coverage_level
      comment: "Coverage level (Full, Partial, Limited) for benefit richness analysis."
    - name: "coverage_scope"
      expr: coverage_scope
      comment: "Scope of coverage for program benefit design analysis."
    - name: "is_covered"
      expr: is_covered
      comment: "Whether the program service is covered under the plan."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required for program services."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the program coverage became effective for trend analysis."
  measures:
    - name: "total_program_coverages"
      expr: COUNT(1)
      comment: "Total count of program coverage records. Baseline for care program benefit portfolio."
    - name: "active_coverage_count"
      expr: COUNT(CASE WHEN coverage_status = 'Active' THEN program_coverage_id END)
      comment: "Count of active program coverages. Tracks live care program benefit portfolio."
    - name: "covered_program_count"
      expr: COUNT(CASE WHEN is_covered = TRUE THEN program_coverage_id END)
      comment: "Count of covered program services. Tracks care program benefit availability."
    - name: "coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_covered = TRUE THEN program_coverage_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of program services that are covered. Measures care program benefit generosity."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_auth_required = TRUE THEN program_coverage_id END)
      comment: "Count of program coverages requiring prior authorization. Drives UM workload for care programs."
    - name: "prior_auth_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_auth_required = TRUE THEN program_coverage_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of program coverages requiring prior authorization. Tracks care program access barriers."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount for program services. Tracks member cost burden for care program participation."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate for program services. Monitors member cost-sharing in care programs."
    - name: "avg_coverage_limit_amount"
      expr: AVG(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Average coverage limit amount for program services. Tracks benefit cap exposure in care programs."
    - name: "distinct_programs_covered"
      expr: COUNT(DISTINCT program_id)
      comment: "Number of distinct care programs with coverage. Measures care management program portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan status transition analytics: status change volumes, compliance flags, transition patterns by market segment and plan type, and audit trail health for plan governance."
  source: "`vibe_health_insurance_v1`.`plan`.`status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New status after the transition for status distribution analysis."
    - name: "prior_status"
      expr: prior_status
      comment: "Prior status before the transition for transition pattern analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the status change for product-level analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for the status change for segmented analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the status change for annual cycle analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the status change for regional analysis."
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic compliance analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the status change has compliance implications."
    - name: "triggered_by"
      expr: triggered_by
      comment: "What triggered the status change (User, System, Regulatory) for root cause analysis."
    - name: "transition_date_month"
      expr: DATE_TRUNC('MONTH', transition_effective_date)
      comment: "Month of the status transition for trend analysis."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total count of plan status transitions. Baseline for plan change activity and governance workload."
    - name: "compliance_flagged_transition_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN status_history_id END)
      comment: "Count of status transitions with compliance flags. Tracks regulatory risk events in plan lifecycle."
    - name: "compliance_flag_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN status_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status transitions flagged for compliance. Measures regulatory risk density in plan changes."
    - name: "distinct_plans_with_transitions"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Number of distinct plans with status transitions. Tracks plan change activity breadth."
    - name: "distinct_transition_types"
      expr: COUNT(DISTINCT new_status)
      comment: "Number of distinct new statuses reached. Measures status transition diversity in the portfolio."
    - name: "legacy_transition_count"
      expr: COUNT(CASE WHEN is_legacy = TRUE THEN status_history_id END)
      comment: "Count of legacy status transitions. Tracks historical data migration completeness."
    - name: "regulatory_action_transition_count"
      expr: COUNT(CASE WHEN regulatory_action_reference IS NOT NULL AND regulatory_action_reference != '' THEN status_history_id END)
      comment: "Count of status transitions driven by regulatory actions. Tracks regulatory enforcement impact on plan portfolio."
$$;