-- Metric views for domain: plan | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_health_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core health plan metrics covering plan portfolio composition, premium economics, cost-sharing structure, and risk adjustment — the central fact table for plan-level strategic KPIs."
  source: "`health_insurance_ecm`.`plan`.`health_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of health plan (HMO, PPO, EPO, POS, HDHP, etc.) — primary segmentation for plan portfolio analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Commercial, Medicare, Medicaid, Individual, etc.) — key strategic segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (Small Group, Large Group, Individual, etc.) for market-level analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current lifecycle status of the plan (Active, Terminated, Pending, etc.)."
    - name: "plan_category"
      expr: plan_category
      comment: "Metal tier or plan category (Bronze, Silver, Gold, Platinum, Catastrophic)."
    - name: "plan_state"
      expr: plan_state
      comment: "State where the plan is offered — geographic segmentation for regulatory and market analysis."
    - name: "plan_region"
      expr: plan_region
      comment: "Region where the plan operates for regional performance comparison."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan benefit year for year-over-year trending."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier designation (Tier 1, Tier 2, etc.) for network strategy analysis."
    - name: "is_aca_compliant"
      expr: plan_aca_compliant
      comment: "Whether the plan is ACA-compliant — critical for regulatory reporting."
    - name: "is_marketplace_eligible"
      expr: plan_marketplace_eligible
      comment: "Whether the plan is eligible for marketplace/exchange listing."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the plan for compliance segmentation."
    - name: "premium_frequency"
      expr: premium_frequency
      comment: "Premium billing frequency (Monthly, Quarterly, Annual)."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the plan became effective for cohort analysis."
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total number of health plans in the portfolio — baseline for plan inventory management."
    - name: "active_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active health plans — core operational metric for portfolio health."
    - name: "avg_premium_amount"
      expr: AVG(CAST(premium_amount AS DOUBLE))
      comment: "Average premium amount across plans — key pricing benchmark for competitive positioning and revenue forecasting."
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total premium amount across all plans — top-line revenue indicator for the plan portfolio."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(deductible_individual AS DOUBLE))
      comment: "Average individual deductible — measures member cost exposure and benefit richness across the portfolio."
    - name: "avg_family_deductible"
      expr: AVG(CAST(deductible_family AS DOUBLE))
      comment: "Average family deductible — measures family cost exposure and informs benefit design strategy."
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum — key consumer protection metric and benefit adequacy indicator."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum — measures financial protection level for families."
    - name: "avg_coinsurance_pct"
      expr: AVG(CAST(coinsurance_percentage AS DOUBLE))
      comment: "Average coinsurance percentage — measures cost-sharing burden on members and informs benefit design."
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay — key access metric; lower copays drive primary care utilization."
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay — measures specialist access affordability across the portfolio."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor — critical for Medicare Advantage and ACA risk corridor analysis."
    - name: "avg_hcc_score"
      expr: AVG(CAST(hcc_score AS DOUBLE))
      comment: "Average HCC (Hierarchical Condition Category) score — measures population acuity and risk profile of the plan portfolio."
    - name: "aca_compliant_plan_count"
      expr: COUNT(CASE WHEN plan_aca_compliant = true THEN 1 END)
      comment: "Count of ACA-compliant plans — regulatory compliance tracking metric."
    - name: "marketplace_eligible_plan_count"
      expr: COUNT(CASE WHEN plan_marketplace_eligible = true THEN 1 END)
      comment: "Count of marketplace-eligible plans — measures exchange participation breadth."
    - name: "distinct_states_served"
      expr: COUNT(DISTINCT plan_state)
      comment: "Number of distinct states served — measures geographic footprint and market reach."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_benefit_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit package metrics covering cost-sharing design, actuarial value, and pharmacy benefit economics — essential for benefit design strategy and competitive benchmarking."
  source: "`health_insurance_ecm`.`plan`.`benefit_package`"
  dimensions:
    - name: "metal_tier"
      expr: metal_tier
      comment: "Metal tier (Bronze, Silver, Gold, Platinum) — primary ACA benefit level classification."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the benefit package (HMO, PPO, etc.)."
    - name: "network_designation"
      expr: network_designation
      comment: "Network designation for the benefit package."
    - name: "deductible_type"
      expr: deductible_type
      comment: "Type of deductible structure (Embedded, Aggregate, etc.)."
    - name: "benefit_package_status"
      expr: benefit_package_status
      comment: "Current status of the benefit package (Active, Pending, Retired)."
    - name: "package_name"
      expr: package_name
      comment: "Name of the benefit package for identification."
    - name: "generic_substitution_required"
      expr: generic_substitution_required
      comment: "Whether generic drug substitution is required — pharmacy cost management indicator."
    - name: "prior_auth_required"
      expr: prior_auth_required
      comment: "Whether prior authorization is required — utilization management indicator."
    - name: "specialty_drug_mgmt_program"
      expr: specialty_drug_management_program
      comment: "Specialty drug management program type for pharmacy strategy analysis."
  measures:
    - name: "total_benefit_packages"
      expr: COUNT(1)
      comment: "Total number of benefit packages — baseline for benefit design inventory."
    - name: "avg_actuarial_value_pct"
      expr: AVG(CAST(actuarial_value_pct AS DOUBLE))
      comment: "Average actuarial value percentage — measures the average share of costs covered by the plan, critical for ACA metal tier compliance and benefit richness assessment."
    - name: "avg_individual_deductible"
      expr: AVG(CAST(individual_deductible_amount AS DOUBLE))
      comment: "Average individual deductible amount across benefit packages — key cost-sharing benchmark."
    - name: "avg_family_deductible"
      expr: AVG(CAST(family_deductible_amount AS DOUBLE))
      comment: "Average family deductible amount — measures family financial exposure."
    - name: "avg_oop_max_individual"
      expr: AVG(CAST(out_of_pocket_max_individual AS DOUBLE))
      comment: "Average individual out-of-pocket maximum — consumer financial protection metric."
    - name: "avg_oop_max_family"
      expr: AVG(CAST(out_of_pocket_max_family AS DOUBLE))
      comment: "Average family out-of-pocket maximum across packages."
    - name: "avg_copay_primary_care"
      expr: AVG(CAST(copay_primary_care AS DOUBLE))
      comment: "Average primary care copay — access affordability metric."
    - name: "avg_copay_specialist"
      expr: AVG(CAST(copay_specialist AS DOUBLE))
      comment: "Average specialist copay — specialist access cost metric."
    - name: "avg_coinsurance_inpatient"
      expr: AVG(CAST(coinsurance_inpatient AS DOUBLE))
      comment: "Average inpatient coinsurance rate — measures member cost burden for hospital stays."
    - name: "avg_coinsurance_outpatient"
      expr: AVG(CAST(coinsurance_outpatient AS DOUBLE))
      comment: "Average outpatient coinsurance rate — measures member cost burden for outpatient services."
    - name: "avg_retail_copay_generic"
      expr: AVG(CAST(retail_copay_generic AS DOUBLE))
      comment: "Average retail generic drug copay — pharmacy access and affordability metric."
    - name: "avg_retail_copay_brand"
      expr: AVG(CAST(retail_copay_brand AS DOUBLE))
      comment: "Average retail brand drug copay — measures brand drug cost-sharing level."
    - name: "avg_specialty_copay"
      expr: AVG(CAST(specialty_copay AS DOUBLE))
      comment: "Average specialty drug copay — critical for specialty pharmacy cost management strategy."
    - name: "avg_mail_order_copay_generic"
      expr: AVG(CAST(mail_order_copay_generic AS DOUBLE))
      comment: "Average mail-order generic copay — measures mail-order pharmacy incentive level."
    - name: "avg_mail_order_copay_brand"
      expr: AVG(CAST(mail_order_copay_brand AS DOUBLE))
      comment: "Average mail-order brand copay — mail-order pharmacy cost metric."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate and premium metrics for pricing analysis, rate adequacy assessment, and regulatory filing — essential for actuarial and financial planning."
  source: "`health_insurance_ecm`.`plan`.`rate`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for rate analysis (Individual, Small Group, Large Group)."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year rate trending."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area code — critical for ACA community rating analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Status of the rate (Active, Filed, Approved, Expired)."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (Standard, Age-Rated, Community-Rated, etc.)."
    - name: "family_tier"
      expr: family_tier
      comment: "Family tier for rate (Employee Only, Employee+Spouse, Family, etc.)."
    - name: "plan_designation"
      expr: plan_designation
      comment: "Plan designation associated with the rate."
    - name: "is_tobacco_surcharge"
      expr: is_tobacco_surcharge_applicable
      comment: "Whether tobacco surcharge applies — wellness incentive and pricing factor."
    - name: "regulatory_filing_type"
      expr: regulatory_filing_type
      comment: "Type of regulatory filing for the rate."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the rate becomes effective for cohort trending."
  measures:
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total number of rate records — baseline for rate filing inventory."
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate — foundational pricing metric for rate adequacy and competitive benchmarking."
    - name: "avg_age_rated_premium"
      expr: AVG(CAST(age_rated_premium AS DOUBLE))
      comment: "Average age-rated premium — measures age-adjusted pricing across the portfolio."
    - name: "avg_family_tier_premium"
      expr: AVG(CAST(family_tier_premium AS DOUBLE))
      comment: "Average family tier premium — measures family coverage pricing levels."
    - name: "total_base_rate_volume"
      expr: SUM(CAST(base_rate AS DOUBLE))
      comment: "Sum of all base rates — aggregate rate volume for portfolio-level financial analysis."
    - name: "avg_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average surcharge amount (e.g., tobacco) — measures surcharge impact on pricing."
    - name: "distinct_rating_areas"
      expr: COUNT(DISTINCT rating_area_code)
      comment: "Number of distinct rating areas served — measures geographic pricing granularity."
    - name: "active_rate_count"
      expr: COUNT(CASE WHEN rate_status = 'Active' THEN 1 END)
      comment: "Count of active rates — operational metric for current pricing inventory."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_cost_share_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-sharing rule metrics covering deductible, copay, coinsurance, and out-of-pocket structures — essential for benefit design governance and member cost exposure analysis."
  source: "`health_insurance_ecm`.`plan`.`cost_share_rule`"
  dimensions:
    - name: "cost_share_category"
      expr: cost_share_category
      comment: "Category of cost-sharing (Medical, Pharmacy, Behavioral Health, etc.)."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of cost-sharing rule (Copay, Coinsurance, Deductible, etc.)."
    - name: "network_type"
      expr: network_type
      comment: "Network type (In-Network, Out-of-Network) — critical for network steerage analysis."
    - name: "member_tier"
      expr: member_tier
      comment: "Member tier (Individual, Family, Employee+1, etc.) for tier-level analysis."
    - name: "cost_share_rule_status"
      expr: cost_share_rule_status
      comment: "Status of the cost-sharing rule (Active, Inactive, Pending)."
    - name: "applies_to_service_category"
      expr: applies_to_service_category
      comment: "Service category the rule applies to for service-level cost analysis."
    - name: "is_hsa_compatible"
      expr: hsa_compatible
      comment: "Whether the rule is HSA-compatible — critical for HDHP/HSA plan design."
    - name: "after_deductible"
      expr: after_deductible
      comment: "Whether cost-sharing applies after deductible is met."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the cost-sharing rule."
  measures:
    - name: "total_cost_share_rules"
      expr: COUNT(1)
      comment: "Total number of cost-sharing rules — baseline for benefit design complexity assessment."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average in-network copay amount — key member cost exposure metric."
    - name: "avg_copay_out_of_network"
      expr: AVG(CAST(copay_amount_out_of_network AS DOUBLE))
      comment: "Average out-of-network copay — measures OON cost differential for network steerage effectiveness."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average in-network coinsurance rate — measures member cost-sharing burden."
    - name: "avg_coinsurance_rate_oon"
      expr: AVG(CAST(coinsurance_rate_out_of_network AS DOUBLE))
      comment: "Average out-of-network coinsurance rate — measures OON cost penalty."
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across rules — measures upfront member cost exposure."
    - name: "avg_out_of_pocket_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average out-of-pocket maximum — measures maximum member financial exposure."
    - name: "avg_max_benefit_amount"
      expr: AVG(CAST(max_benefit_amount AS DOUBLE))
      comment: "Average maximum benefit amount — measures benefit cap levels across rules."
    - name: "hsa_compatible_rule_count"
      expr: COUNT(CASE WHEN hsa_compatible = true THEN 1 END)
      comment: "Count of HSA-compatible rules — measures HDHP/HSA plan design readiness."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan offering metrics covering employer group contributions, enrollment windows, and offering portfolio — essential for group sales strategy and employer relationship management."
  source: "`health_insurance_ecm`.`plan`.`offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of offering (Medical, Dental, Vision, etc.)."
    - name: "offering_status"
      expr: offering_status
      comment: "Status of the offering (Active, Pending, Terminated)."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Type of employer contribution (Fixed, Percentage, Defined Contribution)."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Contribution tier (Employee Only, Employee+Spouse, Family, etc.)."
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the offering becomes effective for trending."
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of plan offerings — measures product distribution breadth."
    - name: "active_offerings"
      expr: COUNT(CASE WHEN offering_status = 'Active' THEN 1 END)
      comment: "Count of active offerings — operational metric for current product availability."
    - name: "avg_employer_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount — key metric for employer cost analysis and competitive positioning."
    - name: "avg_contribution_percent"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage — measures employer generosity and cost-sharing strategy."
    - name: "avg_employee_contribution_amount"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee contribution amount — measures employee cost burden."
    - name: "avg_family_contribution_amount"
      expr: AVG(CAST(family_contribution_amount AS DOUBLE))
      comment: "Average family contribution amount — measures family-level cost exposure."
    - name: "distinct_groups_served"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct employer groups served — measures group client base size."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory submission metrics covering filing status, fees, and compliance timelines — essential for regulatory affairs management and compliance monitoring."
  source: "`health_insurance_ecm`.`plan`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the regulatory submission (Submitted, Approved, Rejected, Withdrawn)."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of submission (Initial, Amendment, Renewal, etc.)."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body the submission is filed with (CMS, State DOI, etc.)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type associated with the submission."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the submission."
    - name: "is_annual_filing"
      expr: is_annual_filing
      comment: "Whether this is an annual filing — distinguishes routine vs. ad-hoc submissions."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of submission for trending analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions — baseline for regulatory workload tracking."
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Count of approved submissions — measures regulatory approval success."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected submissions — measures regulatory compliance risk and quality issues."
    - name: "pending_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Submitted' THEN 1 END)
      comment: "Count of pending/submitted filings — measures regulatory pipeline backlog."
    - name: "total_filing_fee_net"
      expr: SUM(CAST(filing_fee_net AS DOUBLE))
      comment: "Total net filing fees — measures regulatory cost burden."
    - name: "avg_filing_fee_net"
      expr: AVG(CAST(filing_fee_net AS DOUBLE))
      comment: "Average net filing fee per submission — unit cost metric for regulatory operations."
    - name: "total_filing_fee_gross"
      expr: SUM(CAST(filing_fee_gross AS DOUBLE))
      comment: "Total gross filing fees before adjustments — measures total regulatory fee exposure."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan amendment metrics covering change management, cost impact, and regulatory compliance — essential for plan governance and change control oversight."
  source: "`health_insurance_ecm`.`plan`.`plan_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Benefit Change, Rate Change, Network Change, etc.)."
    - name: "plan_amendment_status"
      expr: plan_amendment_status
      comment: "Current status of the amendment (Draft, Pending Approval, Approved, Rejected)."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the amendment."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the amendment — categorizes change drivers."
    - name: "effective_year"
      expr: effective_year
      comment: "Effective year of the amendment for trending."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the amendment is compliance-related."
    - name: "triggers_sbc_generation"
      expr: triggers_sbc_generation
      comment: "Whether the amendment triggers SBC document regeneration."
    - name: "member_notification_required"
      expr: member_notification_required
      comment: "Whether member notification is required — measures member communication burden."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of plan amendments — measures plan change velocity and governance workload."
    - name: "approved_amendments"
      expr: COUNT(CASE WHEN plan_amendment_status = 'Approved' THEN 1 END)
      comment: "Count of approved amendments — measures change throughput."
    - name: "pending_amendments"
      expr: COUNT(CASE WHEN plan_amendment_status = 'Pending Approval' THEN 1 END)
      comment: "Count of pending amendments — measures change backlog."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Average estimated cost impact per amendment — measures financial impact of plan changes."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(impact_estimated_cost AS DOUBLE))
      comment: "Total estimated cost impact of all amendments — aggregate financial impact of plan changes."
    - name: "avg_estimated_member_cost_impact"
      expr: AVG(CAST(impact_estimated_member_cost AS DOUBLE))
      comment: "Average estimated member cost impact — measures how amendments affect member out-of-pocket costs."
    - name: "compliance_driven_amendments"
      expr: COUNT(CASE WHEN compliance_flag = true THEN 1 END)
      comment: "Count of compliance-driven amendments — measures regulatory change burden."
    - name: "sbc_triggering_amendments"
      expr: COUNT(CASE WHEN triggers_sbc_generation = true THEN 1 END)
      comment: "Count of amendments triggering SBC regeneration — measures SBC document management workload."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_rx_benefit_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy benefit configuration metrics covering drug cost-sharing, coverage limits, and formulary management — essential for pharmacy benefit strategy and cost containment."
  source: "`health_insurance_ecm`.`plan`.`rx_benefit_config`"
  dimensions:
    - name: "cost_sharing_method"
      expr: cost_sharing_method
      comment: "Method of pharmacy cost-sharing (Copay, Coinsurance, etc.)."
    - name: "rx_benefit_config_status"
      expr: rx_benefit_config_status
      comment: "Status of the Rx benefit configuration (Active, Inactive, Pending)."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the Rx benefit."
    - name: "mail_order_network_type"
      expr: mail_order_network_type
      comment: "Mail-order pharmacy network type."
    - name: "retail_network_type"
      expr: retail_network_type
      comment: "Retail pharmacy network type."
    - name: "specialty_pharmacy_network"
      expr: specialty_pharmacy_network
      comment: "Specialty pharmacy network designation."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Whether step therapy is required — utilization management indicator."
    - name: "deductible_applicable"
      expr: deductible_applicable
      comment: "Whether pharmacy deductible applies — cost structure indicator."
    - name: "is_specialty_drug_excluded"
      expr: is_specialty_drug_excluded
      comment: "Whether specialty drugs are excluded — critical for specialty cost management."
    - name: "pbm_vendor"
      expr: pbm_vendor
      comment: "PBM vendor managing the pharmacy benefit."
  measures:
    - name: "total_rx_configs"
      expr: COUNT(1)
      comment: "Total number of Rx benefit configurations — baseline for pharmacy benefit inventory."
    - name: "avg_rx_deductible"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average pharmacy deductible amount — measures upfront drug cost exposure for members."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average pharmacy coinsurance rate — measures drug cost-sharing burden."
    - name: "avg_coverage_limit_per_year"
      expr: AVG(CAST(coverage_limit_per_year AS DOUBLE))
      comment: "Average annual coverage limit — measures pharmacy benefit cap levels."
    - name: "avg_coverage_limit_per_rx"
      expr: AVG(CAST(coverage_limit_per_prescription AS DOUBLE))
      comment: "Average per-prescription coverage limit — measures per-fill benefit cap."
    - name: "avg_max_coverage_amount"
      expr: AVG(CAST(max_coverage_amount AS DOUBLE))
      comment: "Average maximum coverage amount — measures overall pharmacy benefit ceiling."
    - name: "avg_oop_max"
      expr: AVG(CAST(out_of_pocket_max AS DOUBLE))
      comment: "Average pharmacy out-of-pocket maximum — measures maximum member drug cost exposure."
    - name: "specialty_excluded_count"
      expr: COUNT(CASE WHEN is_specialty_drug_excluded = true THEN 1 END)
      comment: "Count of configs excluding specialty drugs — measures specialty drug access restrictions."
    - name: "step_therapy_required_count"
      expr: COUNT(CASE WHEN step_therapy_required = true THEN 1 END)
      comment: "Count of configs requiring step therapy — measures utilization management intensity."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service area metrics covering geographic coverage, regulatory compliance, and market presence — essential for network adequacy and market expansion strategy."
  source: "`health_insurance_ecm`.`plan`.`plan_service_area`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State of the service area for geographic analysis."
    - name: "county"
      expr: county
      comment: "County of the service area for granular geographic analysis."
    - name: "service_area_type"
      expr: service_area_type
      comment: "Type of service area (County, ZIP, Region, etc.)."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage in the service area (Medical, Dental, Vision, etc.)."
    - name: "exchange_market"
      expr: exchange_market
      comment: "Exchange/marketplace designation (On-Exchange, Off-Exchange)."
    - name: "network_type"
      expr: network_type
      comment: "Network type in the service area."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the service area (Active, Pending, Retired)."
    - name: "plan_category"
      expr: plan_category
      comment: "Plan category for the service area."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for the service area."
    - name: "is_regulatory_compliant"
      expr: is_regulatory_compliant
      comment: "Whether the service area meets regulatory compliance requirements."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the service area."
  measures:
    - name: "total_service_areas"
      expr: COUNT(1)
      comment: "Total number of service areas — measures geographic coverage breadth."
    - name: "active_service_areas"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of active service areas — measures current geographic footprint."
    - name: "distinct_states"
      expr: COUNT(DISTINCT state)
      comment: "Number of distinct states with service areas — measures state-level market presence."
    - name: "distinct_counties"
      expr: COUNT(DISTINCT county)
      comment: "Number of distinct counties served — measures county-level geographic penetration."
    - name: "regulatory_compliant_areas"
      expr: COUNT(CASE WHEN is_regulatory_compliant = true THEN 1 END)
      comment: "Count of regulatory-compliant service areas — compliance monitoring metric."
    - name: "medicare_eligible_areas"
      expr: COUNT(CASE WHEN is_medicare_eligible = true THEN 1 END)
      comment: "Count of Medicare-eligible service areas — measures Medicare market footprint."
    - name: "medicaid_eligible_areas"
      expr: COUNT(CASE WHEN is_medicaid_eligible = true THEN 1 END)
      comment: "Count of Medicaid-eligible service areas — measures Medicaid market footprint."
    - name: "exchange_market_areas"
      expr: COUNT(CASE WHEN exchange_market IS NOT NULL THEN 1 END)
      comment: "Count of service areas with exchange/marketplace presence — measures marketplace participation."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`plan_hsa_hra_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HSA/HRA configuration metrics covering contribution limits, employer funding, and account design — essential for consumer-directed health plan strategy and HDHP management."
  source: "`health_insurance_ecm`.`plan`.`hsa_hra_config`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of account (HSA, HRA, FSA) — primary segmentation for consumer-directed benefit analysis."
    - name: "contribution_source"
      expr: contribution_source
      comment: "Source of contributions (Employer, Employee, Both)."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Frequency of contributions (Monthly, Quarterly, Annual, Per-Pay-Period)."
    - name: "contribution_method"
      expr: contribution_method
      comment: "Method of contribution (Pre-Tax, Post-Tax, etc.)."
    - name: "hsa_hra_config_status"
      expr: hsa_hra_config_status
      comment: "Status of the HSA/HRA configuration (Active, Inactive, Pending)."
    - name: "rollover_allowed"
      expr: rollover_allowed
      comment: "Whether rollover is allowed — key benefit design feature."
    - name: "eligibility_hdpp"
      expr: eligibility_hdpp
      comment: "Whether HDHP eligibility is required — HSA qualification indicator."
    - name: "catch_up_eligible"
      expr: catch_up_contribution_eligible
      comment: "Whether catch-up contributions are eligible (age 55+)."
  measures:
    - name: "total_hsa_hra_configs"
      expr: COUNT(1)
      comment: "Total number of HSA/HRA configurations — baseline for consumer-directed benefit inventory."
    - name: "avg_contribution_limit"
      expr: AVG(CAST(contribution_limit_amount AS DOUBLE))
      comment: "Average contribution limit amount — measures contribution ceiling across accounts."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution amount — measures employer funding generosity for consumer-directed accounts."
    - name: "avg_employee_contribution_limit"
      expr: AVG(CAST(employee_contribution_limit AS DOUBLE))
      comment: "Average employee contribution limit — measures employee savings opportunity."
    - name: "avg_irs_minimum_deductible"
      expr: AVG(CAST(irs_minimum_deductible AS DOUBLE))
      comment: "Average IRS minimum deductible — measures HDHP qualification threshold compliance."
    - name: "avg_irs_oop_max"
      expr: AVG(CAST(irs_out_of_pocket_max AS DOUBLE))
      comment: "Average IRS out-of-pocket maximum — measures IRS OOP limit compliance."
    - name: "avg_rollover_limit"
      expr: AVG(CAST(rollover_limit_amount AS DOUBLE))
      comment: "Average rollover limit amount — measures carryover benefit generosity."
    - name: "rollover_enabled_count"
      expr: COUNT(CASE WHEN rollover_allowed = true THEN 1 END)
      comment: "Count of configurations with rollover enabled — measures rollover adoption."
    - name: "regulatory_compliant_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = true THEN 1 END)
      comment: "Count of regulatory-compliant configurations — compliance monitoring metric."
$$;