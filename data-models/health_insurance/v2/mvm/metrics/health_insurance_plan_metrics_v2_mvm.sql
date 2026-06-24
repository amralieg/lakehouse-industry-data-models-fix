-- Metric views for domain: plan | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the health plan portfolio — premium economics, cost-sharing design, risk profile, and enrollment window coverage. Used by product, actuarial, and executive teams to steer plan design and pricing decisions."
  source: "`vibe_health_insurance_v1`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year (e.g. 2024) — primary time dimension for year-over-year trend analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type (HMO, PPO, EPO, HDHP, etc.) — key product segmentation dimension."
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (Active, Terminated, Pending) — used to filter active portfolio."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, etc.) — critical segmentation for regulatory and financial reporting."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — drives pricing strategy and regulatory requirements."
    - name: "plan_state"
      expr: plan_state
      comment: "State in which the plan is offered — geographic segmentation for compliance and market analysis."
    - name: "plan_category"
      expr: plan_category
      comment: "ACA metal tier or plan category (Bronze, Silver, Gold, Platinum) — used for actuarial value benchmarking."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan — used for compliance reporting and regulatory segmentation."
    - name: "plan_aca_compliant"
      expr: plan_aca_compliant
      comment: "Boolean flag indicating whether the plan is ACA-compliant — critical for regulatory risk monitoring."
    - name: "plan_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Boolean flag indicating marketplace eligibility — used to segment exchange vs. off-exchange plans."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation of the plan — used to analyze cost and access trade-offs across network designs."
  measures:
    - name: "total_plans"
      expr: COUNT(DISTINCT health_plan_id)
      comment: "Total number of distinct health plans in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "avg_monthly_premium"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average monthly premium amount across plans. Tracks pricing competitiveness and affordability trends — a key executive lever for market positioning."
    - name: "total_premium_revenue_potential"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Sum of premium amounts across all plans. Proxy for total premium revenue potential in the portfolio — used in financial planning and actuarial reviews."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible across plans. Measures member cost-sharing burden — used by product teams to benchmark plan design against market standards."
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible across plans. Tracks family cost-sharing design — used in benefit design reviews and competitive benchmarking."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. Key member financial protection metric — regulators and executives monitor this for ACA compliance and member affordability."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial exposure — used in plan design and regulatory compliance reviews."
    - name: "avg_hcc_risk_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) risk score across plans. Measures the risk profile of the enrolled population — directly drives risk adjustment revenue and actuarial pricing decisions."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across plans. Quantifies expected risk adjustment transfers — a critical financial metric for ACA-compliant plans affecting net premium revenue."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay across plans. Measures member access cost to primary care — used in benefit design and network strategy decisions."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay across plans. Tracks specialist access cost — used to evaluate plan design competitiveness and utilization management effectiveness."
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage across plans. Measures the member cost-sharing rate after deductible — key actuarial and product design metric."
    - name: "pct_aca_compliant_plans"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_aca_compliant = TRUE THEN health_plan_id END) / NULLIF(COUNT(health_plan_id), 0), 2)
      comment: "Percentage of plans that are ACA-compliant. Regulatory risk KPI — a decline signals compliance exposure requiring immediate executive action."
    - name: "pct_marketplace_eligible_plans"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_marketplace_eligible = TRUE THEN health_plan_id END) / NULLIF(COUNT(health_plan_id), 0), 2)
      comment: "Percentage of plans eligible for marketplace/exchange distribution. Tracks market reach and exchange strategy — used in growth and distribution planning."
    - name: "pct_mlr_exempt_plans"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exempt_from_mlr = TRUE THEN health_plan_id END) / NULLIF(COUNT(health_plan_id), 0), 2)
      comment: "Percentage of plans exempt from Medical Loss Ratio (MLR) requirements. Regulatory and financial risk metric — MLR exemptions affect rebate obligations and financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for benefit package design — actuarial value, cost-sharing structure, deductible and OOP levels, and pharmacy cost-sharing. Used by actuarial, product, and compliance teams to evaluate and compare benefit package designs."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit_package`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the benefit package (HMO, PPO, HDHP, etc.) — primary segmentation for benefit design analysis."
    - name: "metal_tier"
      expr: metal_tier
      comment: "ACA metal tier (Bronze, Silver, Gold, Platinum) — used to benchmark actuarial value and cost-sharing against regulatory standards."
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Lifecycle status of the benefit package (Active, Inactive, Pending) — used to filter active packages for operational reporting."
    - name: "package_code"
      expr: package_code
      comment: "Unique code identifying the benefit package — used for cross-referencing with plan documents and regulatory filings."
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Boolean flag indicating whether generic drug substitution is required — used in pharmacy cost management analysis."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Boolean flag indicating whether prior authorization is required — used to assess utilization management stringency."
    - name: "specialty_drug_management_program"
      expr: specialty_drug_management_program
      comment: "Specialty drug management program associated with the package — used to evaluate specialty pharmacy cost controls."
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(DISTINCT benefit_package_id)
      comment: "Total number of distinct benefit packages. Baseline portfolio size metric for benefit design governance."
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage across benefit packages. Core regulatory metric — ACA requires minimum actuarial values by metal tier; deviations trigger compliance risk."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount across benefit packages. Measures member cost-sharing burden — used in benefit design benchmarking and affordability analysis."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount. Tracks family financial exposure in plan design — used in competitive benchmarking and actuarial reviews."
    - name: "avg_individual_oop_max"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum. Key member financial protection metric — ACA caps OOP maximums annually; exceeding limits creates regulatory liability."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial protection levels — used in regulatory compliance and benefit design reviews."
    - name: "avg_primary_care_copay"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay across benefit packages. Measures access cost to primary care — used to evaluate plan competitiveness and member utilization patterns."
    - name: "avg_specialist_copay"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay. Tracks specialist access cost — used in network strategy and utilization management decisions."
    - name: "avg_inpatient_coinsurance"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate. Measures member cost-sharing for hospital admissions — a key driver of member financial risk and plan design competitiveness."
    - name: "avg_outpatient_coinsurance"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate. Tracks member cost-sharing for outpatient services — used in benefit design and actuarial value calculations."
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail copay for generic drugs. Pharmacy cost-sharing metric — used to evaluate generic drug affordability and formulary design effectiveness."
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail copay for brand-name drugs. Tracks brand drug cost-sharing — used in formulary management and pharmacy benefit design decisions."
    - name: "avg_mail_order_copay_generic"
      expr: AVG(CAST(mail_order_copay_generic AS DOUBLE))
      comment: "Average mail-order copay for generic drugs. Measures mail-order pharmacy affordability — used to drive member channel shift to lower-cost mail-order fulfillment."
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay. Specialty pharmacy is the fastest-growing cost driver in health insurance — this metric is critical for pharmacy cost management strategy."
    - name: "pct_packages_requiring_prior_auth"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_auth_required = TRUE THEN benefit_package_id END) / NULLIF(COUNT(benefit_package_id), 0), 2)
      comment: "Percentage of benefit packages requiring prior authorization. Measures utilization management coverage — used to balance cost control with member access and regulatory scrutiny."
    - name: "pct_packages_requiring_generic_substitution"
      expr: ROUND(100.0 * COUNT(CASE WHEN generic_substitution_required = TRUE THEN benefit_package_id END) / NULLIF(COUNT(benefit_package_id), 0), 2)
      comment: "Percentage of benefit packages requiring generic drug substitution. Pharmacy cost management KPI — generic substitution is a primary lever for reducing pharmacy spend."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_benefit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for individual benefit design — coverage limits, cost-sharing amounts, authorization requirements, and regulatory classification. Used by product, compliance, and clinical teams to govern benefit coverage decisions."
  source: "`vibe_health_insurance_v1`.`plan`.`benefit`"
  dimensions:
    - name: "benefit_group"
      expr: benefit_group
      comment: "Benefit group classification (e.g. Medical, Dental, Vision, Behavioral Health) — primary segmentation for benefit portfolio analysis."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type (In-Network, Out-of-Network, Both) — used to evaluate network adequacy and member access."
    - name: "benefit_status"
      expr: benefit_status
      comment: "Lifecycle status of the benefit (Active, Inactive, Pending) — used to filter active benefits for operational reporting."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year associated with the benefit — used for year-over-year benefit design trend analysis."
    - name: "ehb_classification"
      expr: ehb_classification
      comment: "Essential Health Benefit (EHB) classification — ACA requires coverage of EHBs; this dimension is critical for regulatory compliance reporting."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the benefit — used for compliance reporting and regulatory audit support."
    - name: "authorization_required"
      expr: authorization_required
      comment: "Boolean flag indicating whether prior authorization is required for this benefit — used in utilization management analysis."
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization required (Pre-Auth, Concurrent, Retrospective) — used to assess utilization management complexity."
    - name: "preventive_service_flag"
      expr: preventive_service_flag
      comment: "Boolean flag indicating whether the benefit is a preventive service — ACA mandates first-dollar coverage for preventive services; critical for compliance monitoring."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier for drug benefits (Tier 1–5) — used in pharmacy benefit design and cost-sharing analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag indicating whether the benefit is mandated (state or federal) — used to track regulatory mandate compliance."
    - name: "wellness_mandate_flag"
      expr: wellness_mandate_flag
      comment: "Boolean flag indicating whether the benefit is subject to a wellness mandate — used in wellness program compliance tracking."
  measures:
    - name: "total_benefits"
      expr: COUNT(DISTINCT benefit_id)
      comment: "Total number of distinct benefits configured. Baseline metric for benefit portfolio breadth — used in plan design governance."
    - name: "avg_cost_sharing_amount"
      expr: AVG(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Average cost-sharing amount per benefit. Measures member financial burden at the benefit level — used in affordability analysis and benefit design benchmarking."
    - name: "avg_cost_sharing_percent"
      expr: AVG(CAST(cost_sharing_percent AS DOUBLE))
      comment: "Average cost-sharing percentage per benefit. Tracks the coinsurance rate applied at the benefit level — used in actuarial value calculations and plan design reviews."
    - name: "avg_limit_value"
      expr: AVG(CAST(limit_value AS DOUBLE))
      comment: "Average benefit limit value (e.g. visit limits, day limits). Measures coverage generosity — used to identify restrictive benefits that may create member access or regulatory issues."
    - name: "avg_oop_max_amount"
      expr: AVG(CAST(oop_max_amount AS DOUBLE))
      comment: "Average out-of-pocket maximum amount at the benefit level. Tracks member financial protection — used in ACA compliance monitoring and benefit design reviews."
    - name: "avg_moop_max_amount"
      expr: AVG(CAST(moop_max_amount AS DOUBLE))
      comment: "Average maximum out-of-pocket (MOOP) amount at the benefit level. ACA MOOP limits are federally regulated — exceeding them creates significant compliance and financial liability."
    - name: "pct_benefits_requiring_authorization"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_required = TRUE THEN benefit_id END) / NULLIF(COUNT(benefit_id), 0), 2)
      comment: "Percentage of benefits requiring prior authorization. Utilization management coverage rate — used to balance cost control with member access and regulatory scrutiny of prior auth practices."
    - name: "pct_preventive_benefits"
      expr: ROUND(100.0 * COUNT(CASE WHEN preventive_service_flag = TRUE THEN benefit_id END) / NULLIF(COUNT(benefit_id), 0), 2)
      comment: "Percentage of benefits classified as preventive services. ACA compliance KPI — all preventive services must be covered at no cost-sharing; this metric monitors compliance exposure."
    - name: "pct_mandatory_benefits"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE THEN benefit_id END) / NULLIF(COUNT(benefit_id), 0), 2)
      comment: "Percentage of benefits that are mandated (state or federal). Regulatory compliance metric — tracks the proportion of the benefit portfolio driven by mandates vs. voluntary design choices."
    - name: "pct_benefits_with_exclusions"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusion_code IS NOT NULL THEN benefit_id END) / NULLIF(COUNT(benefit_id), 0), 2)
      comment: "Percentage of benefits with an exclusion code applied. Tracks coverage restriction prevalence — used in member advocacy, regulatory review, and plan design quality assurance."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium rate KPIs — base rates, age-rated premiums, family tier premiums, and tobacco surcharges. Used by actuarial, pricing, and regulatory teams to monitor rate adequacy, equity, and filing compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`rate`"
  dimensions:
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the rate — primary time dimension for rate trend and year-over-year pricing analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Individual, Small Group, Large Group) — used to segment rate analysis by regulatory and pricing context."
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier (Employee Only, Employee + Spouse, Family, etc.) — used to analyze premium distribution across coverage tiers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the rate — used for multi-currency rate normalization in financial reporting."
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation (On-Exchange, Off-Exchange, Both) — used to segment rates by distribution channel."
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory rate filing (Initial, Amendment, Renewal) — used in regulatory compliance and filing management."
    - name: "underwriting_class_code"
      expr: underwriting_class_code
      comment: "Underwriting class code — used to segment rates by risk class for actuarial and pricing analysis."
    - name: "is_tobacco_surcharge_applicable"
      expr: is_tobacco_surcharge_applicable
      comment: "Boolean flag indicating whether a tobacco surcharge applies — used to monitor tobacco rating practices and ACA compliance."
    - name: "tobacco_use_indicator"
      expr: tobacco_use_indicator
      comment: "Boolean flag indicating tobacco use for the rated member — used in tobacco surcharge analysis and actuarial risk segmentation."
  measures:
    - name: "total_rate_records"
      expr: COUNT(DISTINCT rate_id)
      comment: "Total number of distinct rate records. Baseline metric for rate filing volume — used in regulatory filing management and rate governance."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base premium rate. Core pricing KPI — tracks rate level trends and is used in rate adequacy reviews, competitive benchmarking, and regulatory filings."
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium. Measures the impact of age rating on premium levels — used in actuarial pricing reviews and ACA age-rating compliance (3:1 ratio limit)."
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium. Tracks family coverage affordability — used in employer contribution strategy and competitive benchmarking."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average tobacco surcharge amount. Monitors tobacco rating practices — ACA limits tobacco surcharges to 1.5x the base rate; deviations create regulatory liability."
    - name: "total_surcharge_revenue_potential"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total tobacco surcharge amount across all rate records. Quantifies the financial impact of tobacco rating — used in premium revenue forecasting and actuarial analysis."
    - name: "pct_rates_with_tobacco_surcharge"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_tobacco_surcharge_applicable = TRUE THEN rate_id END) / NULLIF(COUNT(rate_id), 0), 2)
      comment: "Percentage of rate records with a tobacco surcharge applicable. Tracks tobacco rating prevalence — used in actuarial risk segmentation and ACA compliance monitoring."
    - name: "age_to_base_rate_ratio"
      expr: ROUND(AVG(CAST(age_rated_premium AS DOUBLE)) / NULLIF(AVG(CAST(base_rate AS DOUBLE)), 0), 4)
      comment: "Ratio of average age-rated premium to average base rate. ACA compliance KPI — the age rating ratio must not exceed 3:1; this metric provides early warning of rating violations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for cost-sharing rule design — deductible levels, OOP maximums, copay and coinsurance rates, and HSA compatibility. Used by actuarial, product, and compliance teams to govern cost-sharing structures and ensure regulatory compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule (Deductible, Copay, Coinsurance, OOP Max) — primary segmentation for cost-sharing analysis."
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network) — used to compare in-network vs. out-of-network cost-sharing levels."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier (Individual, Family, Employee+Spouse, etc.) — used to analyze cost-sharing by coverage tier."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the cost-sharing rule — used for compliance reporting and regulatory audit support."
    - name: "hsa_compatible"
      expr: hsa_compatible
      comment: "Boolean flag indicating HSA compatibility — HSA-compatible plans have specific IRS deductible and OOP requirements; critical for HDHP compliance monitoring."
    - name: "after_deductible"
      expr: after_deductible
      comment: "Boolean flag indicating whether the rule applies after the deductible is met — used to understand cost-sharing sequencing in plan design."
    - name: "prior_to_deductible"
      expr: prior_to_deductible
      comment: "Boolean flag indicating whether the rule applies prior to deductible satisfaction — used to identify first-dollar coverage benefits."
    - name: "applies_to_drug"
      expr: applies_to_drug
      comment: "Boolean flag indicating whether the rule applies to drug benefits — used to segment pharmacy vs. medical cost-sharing analysis."
    - name: "applies_to_procedure"
      expr: applies_to_procedure
      comment: "Boolean flag indicating whether the rule applies to procedures — used in medical cost-sharing analysis."
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Boolean flag indicating whether this is the default cost-sharing rule — used to identify baseline cost-sharing configurations."
    - name: "deductible_aggregate_flag"
      expr: deductible_aggregate_flag
      comment: "Boolean flag indicating whether the deductible is aggregated (family) — used in deductible structure analysis."
    - name: "deductible_embedded_flag"
      expr: deductible_embedded_flag
      comment: "Boolean flag indicating whether the deductible is embedded (individual within family) — used in family deductible structure analysis."
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(DISTINCT cost_share_rule_id)
      comment: "Total number of distinct cost-sharing rules. Baseline metric for cost-sharing rule governance — used to monitor rule proliferation and standardization."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across cost-sharing rules. Core cost-sharing design metric — used in actuarial value calculations and member affordability analysis."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average in-network copay amount. Measures member point-of-service cost — used in benefit design benchmarking and member access analysis."
    - name: "avg_copay_out_of_network"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay amount. Tracks out-of-network cost-sharing burden — used to evaluate network adequacy and member financial risk from out-of-network utilization."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average in-network coinsurance rate. Measures member cost-sharing percentage after deductible — key input to actuarial value calculations."
    - name: "avg_coinsurance_rate_out_of_network"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate. Tracks out-of-network cost-sharing — used to assess financial risk from out-of-network utilization and network adequacy strategy."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average individual out-of-pocket maximum across cost-sharing rules. ACA compliance metric — federal OOP maximums are updated annually; exceeding them creates regulatory liability."
    - name: "avg_family_oop_max"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum. Tracks family financial protection — used in ACA compliance monitoring and benefit design reviews."
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount per cost-sharing rule. Measures coverage caps — used to identify rules with restrictive benefit limits that may create member access or regulatory issues."
    - name: "pct_hsa_compatible_rules"
      expr: ROUND(100.0 * COUNT(CASE WHEN hsa_compatible = TRUE THEN cost_share_rule_id END) / NULLIF(COUNT(cost_share_rule_id), 0), 2)
      comment: "Percentage of cost-sharing rules that are HSA-compatible. HDHP/HSA compliance KPI — IRS requires minimum deductibles and maximum OOP limits for HSA eligibility; non-compliance creates tax liability for members."
    - name: "in_network_vs_out_of_network_copay_ratio"
      expr: ROUND(AVG(CAST(copay_amount_out_of_network AS DOUBLE)) / NULLIF(AVG(CAST(copay_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of average out-of-network copay to average in-network copay. Network steerage effectiveness metric — a higher ratio indicates stronger financial incentives to use in-network providers, reducing plan costs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_network_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for network configuration — out-of-network cost-sharing, network coverage, exclusion rates, and adequacy. Used by network strategy, actuarial, and compliance teams to evaluate network design and regulatory adequacy."
  source: "`vibe_health_insurance_v1`.`plan`.`network_config`"
  dimensions:
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (Tier 1, Tier 2, Preferred, Standard) — used to analyze cost and access trade-offs across network tiers."
    - name: "network_coverage_type"
      expr: network_coverage_type
      comment: "Network coverage type (HMO, PPO, EPO, POS) — primary segmentation for network design analysis."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation (Narrow, Broad, Tiered) — used to evaluate network breadth and its impact on cost and access."
    - name: "access_type"
      expr: access_type
      comment: "Access type (Open Access, Gated, Referral Required) — used to assess member access model and utilization management approach."
    - name: "network_config_status"
      expr: network_config_status
      comment: "Lifecycle status of the network configuration (Active, Inactive, Pending) — used to filter active network configurations."
    - name: "out_of_network_benefit_type"
      expr: out_of_network_benefit_type
      comment: "Type of out-of-network benefit (None, Emergency Only, Full) — used to classify network exclusivity and member out-of-network exposure."
    - name: "network_adequacy_standard_code"
      expr: network_adequacy_standard_code
      comment: "Regulatory network adequacy standard code — used for compliance reporting against CMS and state network adequacy requirements."
    - name: "network_exclusion_flag"
      expr: network_exclusion_flag
      comment: "Boolean flag indicating whether a network exclusion applies — used to monitor network restriction prevalence."
    - name: "out_of_network_coverage_flag"
      expr: out_of_network_coverage_flag
      comment: "Boolean flag indicating whether out-of-network coverage is provided — used to classify network exclusivity."
  measures:
    - name: "total_network_configs"
      expr: COUNT(DISTINCT network_config_id)
      comment: "Total number of distinct network configurations. Baseline metric for network portfolio governance."
    - name: "avg_out_of_network_coinsurance_pct"
      expr: AVG(CAST(out_of_network_coinsurance_pct AS DOUBLE))
      comment: "Average out-of-network coinsurance percentage. Measures member financial exposure for out-of-network utilization — used in network steerage strategy and member financial risk analysis."
    - name: "avg_out_of_network_copay_amount"
      expr: AVG(CAST(out_of_network_copay_amount AS DOUBLE))
      comment: "Average out-of-network copay amount. Tracks out-of-network point-of-service cost — used to evaluate network steerage effectiveness and member financial risk."
    - name: "pct_configs_with_out_of_network_coverage"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_network_coverage_flag = TRUE THEN network_config_id END) / NULLIF(COUNT(network_config_id), 0), 2)
      comment: "Percentage of network configurations providing out-of-network coverage. Tracks network exclusivity — used in product design strategy and member access analysis."
    - name: "pct_configs_with_network_exclusions"
      expr: ROUND(100.0 * COUNT(CASE WHEN network_exclusion_flag = TRUE THEN network_config_id END) / NULLIF(COUNT(network_config_id), 0), 2)
      comment: "Percentage of network configurations with exclusions applied. Network restriction prevalence metric — used in regulatory compliance reviews and member access monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for plan offerings — employer/employee contribution levels, contribution rates, and enrollment window management. Used by benefits administration, finance, and HR teams to evaluate offering economics and enrollment strategy."
  source: "`vibe_health_insurance_v1`.`plan`.`offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of offering (Employer-Sponsored, Individual, Voluntary) — primary segmentation for offering portfolio analysis."
    - name: "offering_status"
      expr: offering_status
      comment: "Lifecycle status of the offering (Active, Inactive, Pending) — used to filter active offerings for operational reporting."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Contribution type (Fixed, Percentage, Tiered) — used to analyze employer contribution strategy and cost-sharing models."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (Employee Only, Employee+Spouse, Family) — used to analyze contribution levels by coverage tier."
  measures:
    - name: "total_offerings"
      expr: COUNT(DISTINCT offering_id)
      comment: "Total number of distinct plan offerings. Baseline metric for offering portfolio size — used in benefits administration governance."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount per offering. Core benefits economics metric — tracks employer cost commitment and is used in total compensation analysis and benefits strategy."
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage. Measures the proportion of premium covered by the employer — used in benefits competitiveness benchmarking and total compensation strategy."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount. Tracks employee premium burden — used in affordability analysis and benefits design decisions."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount. Measures total family premium cost — used in family affordability analysis and benefits strategy."
    - name: "employee_to_total_contribution_ratio"
      expr: ROUND(AVG(CAST(employee_contribution_amount AS DOUBLE)) / NULLIF(AVG(CAST(contribution_amount AS DOUBLE)), 0), 4)
      comment: "Ratio of average employee contribution to average total contribution amount. Measures the employee share of premium cost — a key benefits competitiveness and affordability metric used in HR strategy."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for pharmacy (Rx) benefit configuration — coverage limits, deductibles, OOP maximums, coinsurance rates, and specialty drug management. Used by pharmacy, actuarial, and clinical teams to govern pharmacy benefit design and cost management."
  source: "`vibe_health_insurance_v1`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Lifecycle status of the Rx benefit configuration (Active, Inactive, Pending) — used to filter active configurations."
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail pharmacy network type (Preferred, Standard, Any Willing Provider) — used to analyze retail pharmacy network strategy."
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail-order pharmacy network type — used to analyze mail-order channel strategy and cost management."
    - name: "specialty_pharmacy_network"
      expr: specialty_pharmacy_network
      comment: "Specialty pharmacy network designation — used to evaluate specialty drug access and cost management."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the Rx benefit configuration — used for compliance reporting."
    - name: "deductible_applicable"
      expr: deductible_applicable
      comment: "Boolean flag indicating whether a deductible applies to Rx benefits — used to analyze integrated vs. separate Rx deductible designs."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Boolean flag indicating whether step therapy is required — used to evaluate utilization management stringency for pharmacy benefits."
    - name: "ninety_day_supply_allowed"
      expr: ninety_day_supply_allowed
      comment: "Boolean flag indicating whether 90-day supply is allowed — used to analyze mail-order and adherence program effectiveness."
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Boolean flag indicating whether specialty drugs are excluded — used to monitor specialty drug coverage and formulary design."
    - name: "is_biologic_preferred"
      expr: is_biologic_preferred
      comment: "Boolean flag indicating whether biologics are preferred on the formulary — used in specialty drug cost management strategy."
    - name: "is_biosimilar_preferred"
      expr: is_biosimilar_preferred
      comment: "Boolean flag indicating whether biosimilars are preferred — biosimilar adoption is a major pharmacy cost reduction lever; this dimension tracks formulary strategy."
  measures:
    - name: "total_rx_benefit_configs"
      expr: COUNT(DISTINCT rx_benefit_config_id)
      comment: "Total number of distinct Rx benefit configurations. Baseline metric for pharmacy benefit portfolio governance."
    - name: "avg_rx_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average Rx deductible amount. Measures member pharmacy cost-sharing burden — used in pharmacy benefit design and affordability analysis."
    - name: "avg_rx_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average Rx coinsurance rate. Tracks member cost-sharing percentage for pharmacy benefits — used in actuarial value calculations and pharmacy benefit design reviews."
    - name: "avg_coverage_limit_per_prescription"
      expr: AVG(CAST(coverage_limit_per_prescription AS DOUBLE))
      comment: "Average coverage limit per prescription. Measures per-fill coverage cap — used to identify restrictive Rx benefits that may create adherence or access issues."
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average annual Rx coverage limit. Tracks annual pharmacy benefit caps — used in benefit design and ACA compliance monitoring (annual limits on EHBs are prohibited)."
    - name: "avg_rx_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average Rx out-of-pocket maximum. Measures member pharmacy financial protection — used in ACA compliance monitoring and benefit design reviews."
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum Rx coverage amount. Tracks total pharmacy benefit cap — used in actuarial cost modeling and benefit design governance."
    - name: "pct_configs_with_step_therapy"
      expr: ROUND(100.0 * COUNT(CASE WHEN step_therapy_required = TRUE THEN rx_benefit_config_id END) / NULLIF(COUNT(rx_benefit_config_id), 0), 2)
      comment: "Percentage of Rx benefit configurations requiring step therapy. Utilization management coverage rate — step therapy is a primary pharmacy cost control mechanism; this metric tracks its adoption."
    - name: "pct_configs_with_biosimilar_preference"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_biosimilar_preferred = TRUE THEN rx_benefit_config_id END) / NULLIF(COUNT(rx_benefit_config_id), 0), 2)
      comment: "Percentage of Rx benefit configurations preferring biosimilars. Pharmacy cost management KPI — biosimilar adoption can reduce specialty drug costs by 20-40%; this metric tracks formulary strategy execution."
    - name: "pct_configs_excluding_specialty_drugs"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_specialty_drug_excluded = TRUE THEN rx_benefit_config_id END) / NULLIF(COUNT(rx_benefit_config_id), 0), 2)
      comment: "Percentage of Rx benefit configurations excluding specialty drugs. Specialty drug coverage metric — specialty drugs represent 50%+ of pharmacy spend; exclusion rates directly impact member access and plan cost."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_provider_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for provider contracting — in-network contract rates, reimbursement methods, and contract status. Used by network management, finance, and contracting teams to govern provider relationships and network adequacy."
  source: "`vibe_health_insurance_v1`.`plan`.`provider_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Lifecycle status of the provider contract (Active, Terminated, Pending, Expired) — used to monitor active network coverage."
    - name: "reimbursement_method"
      expr: reimbursement_method
      comment: "Reimbursement method (Fee-for-Service, Capitation, Bundled Payment, Value-Based) — used to analyze payment model mix and value-based care adoption."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Provider relationship type (Primary Care, Specialist, Hospital, Ancillary) — used to segment network analysis by provider type."
    - name: "is_in_network"
      expr: is_in_network
      comment: "Boolean flag indicating whether the provider is in-network — used to monitor network coverage and identify contracting gaps."
  measures:
    - name: "total_provider_contracts"
      expr: COUNT(DISTINCT provider_contract_id)
      comment: "Total number of distinct provider contracts. Baseline network size metric — used in network adequacy monitoring and contracting governance."
    - name: "total_active_provider_contracts"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN provider_contract_id END)
      comment: "Total number of active provider contracts. Active network size KPI — used in network adequacy reporting and regulatory compliance (CMS and state network adequacy standards)."
    - name: "pct_in_network_contracts"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_in_network = TRUE THEN provider_contract_id END) / NULLIF(COUNT(provider_contract_id), 0), 2)
      comment: "Percentage of provider contracts designated as in-network. Network coverage rate — a decline signals network adequacy risk requiring immediate contracting action."
    - name: "pct_value_based_contracts"
      expr: ROUND(100.0 * COUNT(CASE WHEN reimbursement_method IN ('Value-Based', 'Capitation', 'Bundled Payment') THEN provider_contract_id END) / NULLIF(COUNT(provider_contract_id), 0), 2)
      comment: "Percentage of provider contracts using value-based reimbursement methods. Strategic transformation KPI — value-based care adoption is a primary lever for improving quality and reducing total cost of care."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for service area coverage — geographic reach, regulatory compliance, and market eligibility. Used by market expansion, regulatory, and network teams to govern geographic coverage and compliance."
  source: "`vibe_health_insurance_v1`.`plan`.`service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State of the service area — primary geographic dimension for market coverage analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the service area — used for year-over-year geographic expansion analysis."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (County, ZIP, State, Region) — used to analyze geographic coverage granularity."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type for the service area — used to segment geographic coverage by plan type."
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category associated with the service area — used to analyze geographic coverage by metal tier."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange market (Federal, State-Based) — used to segment service areas by marketplace type."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the service area (Active, Inactive, Pending) — used to filter active service areas."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the service area — used to monitor pending approvals and compliance risk."
    - name: "is_medicaid_eligible"
      expr: is_medicaid_eligible
      comment: "Boolean flag indicating Medicaid eligibility in the service area — used in Medicaid market expansion analysis."
    - name: "is_medicare_eligible"
      expr: is_medicare_eligible
      comment: "Boolean flag indicating Medicare eligibility in the service area — used in Medicare Advantage market expansion analysis."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Boolean flag indicating regulatory compliance of the service area — used to monitor compliance risk across geographic markets."
  measures:
    - name: "total_service_areas"
      expr: COUNT(DISTINCT service_area_id)
      comment: "Total number of distinct service areas. Baseline geographic coverage metric — used in market expansion and network adequacy reporting."
    - name: "total_states_covered"
      expr: COUNT(DISTINCT state)
      comment: "Total number of distinct states with service area coverage. Geographic market reach KPI — used in market expansion strategy and regulatory filing management."
    - name: "pct_regulatory_compliant_service_areas"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_compliant = TRUE THEN service_area_id END) / NULLIF(COUNT(service_area_id), 0), 2)
      comment: "Percentage of service areas that are regulatory compliant. Compliance risk KPI — non-compliant service areas create regulatory liability and potential market exit risk."
    - name: "pct_service_areas_approved"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN service_area_id END) / NULLIF(COUNT(service_area_id), 0), 2)
      comment: "Percentage of service areas with regulatory approval. Market readiness KPI — unapproved service areas cannot be used for plan offerings; this metric tracks market launch readiness."
    - name: "pct_medicaid_eligible_service_areas"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_medicaid_eligible = TRUE THEN service_area_id END) / NULLIF(COUNT(service_area_id), 0), 2)
      comment: "Percentage of service areas eligible for Medicaid. Government program market penetration metric — used in Medicaid managed care expansion strategy."
    - name: "pct_medicare_eligible_service_areas"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_medicare_eligible = TRUE THEN service_area_id END) / NULLIF(COUNT(service_area_id), 0), 2)
      comment: "Percentage of service areas eligible for Medicare. Medicare Advantage market opportunity metric — used in MA expansion strategy and CMS bid planning."
$$;