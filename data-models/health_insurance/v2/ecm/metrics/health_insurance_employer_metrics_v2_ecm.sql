-- Metric views for domain: employer | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employer group portfolio metrics tracking group size, risk profile, and enrollment health across the book of business."
  source: "`vibe_health_insurance_v1`.`employer`.`group`"
  dimensions:
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification (small group, large group, individual) for portfolio segmentation."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding type (fully-insured, self-funded, level-funded) driving revenue and risk exposure."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (medical, dental, vision) for product-level analysis."
    - name: "size_tier"
      expr: size_tier
      comment: "Employer size tier (micro, small, mid, large) for segmentation and pricing strategy."
    - name: "group_status"
      expr: group_status
      comment: "Current group lifecycle status (active, terminated, pending) for portfolio health monitoring."
    - name: "domicile_state"
      expr: domicile_state
      comment: "State of domicile for geographic and regulatory analysis."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA plan status indicating regulatory classification and compliance obligations."
    - name: "renewal_date"
      expr: DATE_TRUNC('month', renewal_date)
      comment: "Month of group renewal for pipeline and retention forecasting."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year group became effective for cohort and vintage analysis."
  measures:
    - name: "total_active_groups"
      expr: COUNT(CASE WHEN group_status = 'active' THEN 1 END)
      comment: "Total number of active employer groups in the book of business — primary portfolio size KPI."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor across groups — signals overall portfolio risk level and pricing adequacy."
    - name: "total_avg_claim_cost"
      expr: SUM(CAST(average_claim_cost AS DOUBLE))
      comment: "Sum of average claim costs across groups — proxy for total claims liability exposure in the portfolio."
    - name: "avg_claim_cost_per_group"
      expr: AVG(CAST(average_claim_cost AS DOUBLE))
      comment: "Average claim cost per employer group — benchmarks cost efficiency and informs renewal pricing."
    - name: "groups_renewing_next_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of groups with renewal dates in the next 90 days — critical for retention pipeline management."
    - name: "terminated_group_count"
      expr: COUNT(CASE WHEN group_status = 'terminated' THEN 1 END)
      comment: "Count of terminated groups — tracks lapse/churn rate for retention strategy."
    - name: "self_funded_group_count"
      expr: COUNT(CASE WHEN funding_arrangement = 'self-funded' THEN 1 END)
      comment: "Number of self-funded groups — key segment for ASO fee revenue and stop-loss exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contract financial and lifecycle metrics tracking contract value, funding mix, and renewal pipeline."
  source: "`vibe_health_insurance_v1`.`employer`.`employer_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (ASO, fully-insured, level-funded) for revenue and risk segmentation."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement driving premium vs. fee revenue classification."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated) for portfolio health."
    - name: "employer_contract_status"
      expr: employer_contract_status
      comment: "Employer-specific contract status for operational workflow tracking."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle (monthly, quarterly, annual) for cash flow planning."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Renewal type (auto-renew, negotiated) for retention strategy analysis."
    - name: "plan_year_start"
      expr: DATE_TRUNC('year', plan_year_start)
      comment: "Plan year start for cohort and vintage analysis."
    - name: "aso_funding_arrangement"
      expr: aso_funding_arrangement
      comment: "ASO-specific funding arrangement for administrative services revenue segmentation."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted revenue value across all employer contracts — primary revenue pipeline KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per employer — benchmarks deal size and informs sales strategy."
    - name: "total_aso_fee_revenue"
      expr: SUM(CAST(aso_fee_amount AS DOUBLE))
      comment: "Total ASO administrative fee revenue — key revenue stream for self-funded employer segment."
    - name: "total_admin_fee_revenue"
      expr: SUM(CAST(admin_fee_amount AS DOUBLE))
      comment: "Total administrative fee revenue across contracts — tracks fee-based income separate from premium."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average broker commission rate — informs distribution cost management and profitability."
    - name: "total_stop_loss_attachment"
      expr: SUM(CAST(stop_loss_attachment AS DOUBLE))
      comment: "Total stop-loss attachment point exposure — quantifies reinsurance and risk transfer obligations."
    - name: "contracts_expiring_next_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Contracts expiring within 90 days — critical renewal pipeline metric for retention teams."
    - name: "avg_minimum_participation"
      expr: AVG(CAST(minimum_participation AS DOUBLE))
      comment: "Average minimum participation threshold across contracts — tracks underwriting standards compliance."
    - name: "total_wellness_incentive_budget"
      expr: SUM(CAST(wellness_incentive_amount AS DOUBLE))
      comment: "Total wellness incentive budget committed across contracts — tracks employer wellness investment."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_plan_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group plan offering metrics tracking contribution levels, participation rates, and benefit affordability across employer plan elections."
  source: "`vibe_health_insurance_v1`.`employer`.`group_plan_offering`"
  dimensions:
    - name: "offering_type"
      expr: offering_type
      comment: "Type of plan offering (medical, dental, vision, supplemental) for benefit mix analysis."
    - name: "contribution_type"
      expr: contribution_type
      comment: "Employer contribution type (fixed, percentage, tiered) for cost-sharing strategy analysis."
    - name: "contribution_tier"
      expr: contribution_tier
      comment: "Coverage tier (EE, ES, EC, EF) for family composition and cost analysis."
    - name: "group_plan_offering_status"
      expr: group_plan_offering_status
      comment: "Current offering status (active, terminated, pending) for portfolio management."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for year-over-year contribution and participation trend analysis."
    - name: "is_affordable"
      expr: is_affordable
      comment: "ACA affordability flag — regulatory compliance indicator for employer mandate."
    - name: "waiver_eligible"
      expr: waiver_eligible
      comment: "Whether waiver of coverage is permitted — impacts participation rate calculations."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year offering became effective for cohort analysis."
  measures:
    - name: "total_employer_contribution"
      expr: SUM(CAST(contribution_amount AS DOUBLE))
      comment: "Total employer contribution dollars committed across all plan offerings — primary benefit cost KPI."
    - name: "avg_employer_contribution_pct"
      expr: AVG(CAST(contribution_percent AS DOUBLE))
      comment: "Average employer contribution percentage — benchmarks generosity of benefit packages vs. market."
    - name: "avg_employee_contribution"
      expr: AVG(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Average employee out-of-pocket contribution — measures employee cost burden and plan affordability."
    - name: "total_family_contribution"
      expr: SUM(CAST(family_contribution_amount AS DOUBLE))
      comment: "Total family-tier contribution dollars — tracks dependent coverage cost exposure."
    - name: "avg_minimum_participation_pct"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation threshold — monitors underwriting requirement compliance across offerings."
    - name: "total_hra_seed_committed"
      expr: SUM(CAST(hra_seed_amount AS DOUBLE))
      comment: "Total HRA employer seed dollars committed — tracks health reimbursement account funding obligations."
    - name: "total_hsa_seed_committed"
      expr: SUM(CAST(hsa_seed_amount AS DOUBLE))
      comment: "Total HSA employer seed dollars committed — tracks health savings account funding obligations."
    - name: "affordable_offering_rate"
      expr: COUNT(CASE WHEN is_affordable = TRUE THEN 1 END)
      comment: "Count of ACA-affordable offerings — ACA employer mandate compliance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_rate_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate quote pipeline and conversion metrics tracking premium estimates, quote activity, and underwriting outcomes for employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`rate_quote`"
  dimensions:
    - name: "quote_status"
      expr: rate_quote_status
      comment: "Current quote status (pending, issued, accepted, declined, expired) for pipeline stage analysis."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier quoted (EE, ES, EC, EF) for benefit design and pricing analysis."
    - name: "group_type"
      expr: group_type
      comment: "Employer group type for market segment targeting."
    - name: "group_size"
      expr: group_size
      comment: "Group size band for underwriting and pricing tier analysis."
    - name: "rating_area"
      expr: rating_area
      comment: "Geographic rating area for regional pricing and market analysis."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year for quote vintage and pipeline trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote for multi-currency portfolio management."
    - name: "issue_timestamp"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month quote was issued for pipeline velocity and seasonality analysis."
  measures:
    - name: "total_quotes_issued"
      expr: COUNT(1)
      comment: "Total rate quotes issued — measures sales pipeline volume and underwriting throughput."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month rate — key pricing benchmark for actuarial and underwriting review."
    - name: "total_discount_granted"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars granted across quotes — tracks pricing concessions and margin erosion."
    - name: "total_group_premium_pipeline"
      expr: SUM(CAST(total_group_premium_estimate AS DOUBLE))
      comment: "Total estimated group premium in pipeline — executive-level revenue forecast metric."
    - name: "quotes_expiring_soon"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Quotes expiring within 30 days — urgency metric for sales follow-up and conversion."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_underwriting_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting case metrics tracking risk assessment quality, premium estimates, and underwriting decision outcomes for employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`employer_underwriting_case`"
  dimensions:
    - name: "underwriting_status"
      expr: underwriting_status
      comment: "Current underwriting workflow status for pipeline stage management."
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Final underwriting decision (approved, declined, modified) for acceptance rate analysis."
    - name: "quote_status"
      expr: quote_status
      comment: "Quote status associated with the underwriting case for conversion tracking."
    - name: "rating_methodology"
      expr: rating_methodology
      comment: "Rating methodology applied (experience, manual, blended) for actuarial consistency review."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Assigned risk tier for portfolio risk stratification."
    - name: "rating_area_code"
      expr: rating_area_code
      comment: "Geographic rating area for regional underwriting analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency underwriting portfolio management."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Effective year for underwriting vintage and cohort analysis."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total underwriting cases submitted — measures underwriting pipeline volume."
    - name: "avg_pmpm_estimate"
      expr: AVG(CAST(pmpm_estimate AS DOUBLE))
      comment: "Average PMPM premium estimate — key actuarial benchmark for pricing adequacy review."
    - name: "total_premium_estimate"
      expr: SUM(CAST(total_premium_estimate AS DOUBLE))
      comment: "Total estimated premium across all underwriting cases — measures total revenue pipeline from underwriting."
    - name: "avg_experience_rating_factor"
      expr: AVG(CAST(experience_rating_factor AS DOUBLE))
      comment: "Average experience rating factor — measures how much group-specific claims history adjusts base rates."
    - name: "avg_geographic_factor"
      expr: AVG(CAST(geographic_factor AS DOUBLE))
      comment: "Average geographic adjustment factor — tracks regional cost variation in underwriting."
    - name: "avg_group_average_age"
      expr: AVG(CAST(group_average_age AS DOUBLE))
      comment: "Average group age across underwriting cases — demographic risk indicator for pricing."
    - name: "avg_aca_adjustment_factor"
      expr: AVG(CAST(aca_adjustment_factor AS DOUBLE))
      comment: "Average ACA adjustment factor — measures regulatory risk adjustment impact on pricing."
    - name: "avg_age_gender_composite_factor"
      expr: AVG(CAST(age_gender_composite_factor AS DOUBLE))
      comment: "Average age-gender composite factor — demographic risk loading benchmark for actuarial review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group renewal pipeline and retention metrics tracking renewal outcomes, rate changes, and compliance status across the employer book."
  source: "`vibe_health_insurance_v1`.`employer`.`group_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current renewal status (pending, approved, declined, lapsed) for pipeline management."
    - name: "retention_outcome"
      expr: retention_outcome
      comment: "Retention result (retained, lost, pending) — primary retention KPI dimension."
    - name: "retention_reason_code"
      expr: retention_reason_code
      comment: "Reason code for retention outcome — root cause analysis for churn reduction."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement for renewal segmentation by product type."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status at renewal — flags groups with regulatory issues affecting renewal."
    - name: "renewal_cycle_year"
      expr: renewal_cycle_year
      comment: "Renewal cycle year for year-over-year retention trend analysis."
    - name: "renewal_effective_date"
      expr: DATE_TRUNC('month', renewal_effective_date)
      comment: "Month of renewal effective date for pipeline timing analysis."
  measures:
    - name: "total_renewals"
      expr: COUNT(1)
      comment: "Total renewal cases in pipeline — measures renewal workload and book-of-business activity."
    - name: "retained_group_count"
      expr: COUNT(CASE WHEN retention_outcome = 'retained' THEN 1 END)
      comment: "Number of groups successfully retained at renewal — primary retention performance KPI."
    - name: "lost_group_count"
      expr: COUNT(CASE WHEN retention_outcome = 'lost' THEN 1 END)
      comment: "Number of groups lost at renewal — churn metric driving retention strategy."
    - name: "avg_rate_change_pct"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average premium rate change at renewal — measures pricing pressure and competitiveness."
    - name: "avg_prior_year_premium_rate"
      expr: AVG(CAST(premium_rate_prior_year AS DOUBLE))
      comment: "Average prior year premium rate — baseline for renewal pricing trend analysis."
    - name: "avg_renewal_year_premium_rate"
      expr: AVG(CAST(premium_rate_renewal_year AS DOUBLE))
      comment: "Average renewal year premium rate — measures current pricing level vs. prior year."
    - name: "participation_requirement_met_count"
      expr: COUNT(CASE WHEN participation_requirement_met = TRUE THEN 1 END)
      comment: "Groups meeting participation requirements at renewal — underwriting compliance indicator."
    - name: "regulatory_compliant_renewal_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Renewals with confirmed regulatory compliance — tracks compliance health of renewing book."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_contribution_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer contribution strategy metrics tracking contribution levels, affordability compliance, and benefit funding across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`contribution_strategy`"
  dimensions:
    - name: "contribution_type"
      expr: contribution_type
      comment: "Contribution type (fixed dollar, percentage, tiered) for strategy mix analysis."
    - name: "contribution_frequency"
      expr: contribution_frequency
      comment: "Contribution payment frequency (monthly, bi-weekly) for cash flow planning."
    - name: "affordability_test_flag"
      expr: affordability_test_flag
      comment: "ACA affordability test flag — regulatory compliance indicator for employer mandate."
    - name: "is_pre_tax"
      expr: is_pre_tax
      comment: "Pre-tax contribution flag for tax benefit analysis."
    - name: "is_post_tax"
      expr: is_post_tax
      comment: "Post-tax contribution flag for compensation structure analysis."
    - name: "tax_credit_eligible"
      expr: tax_credit_eligible
      comment: "Tax credit eligibility flag for small employer tax credit tracking."
    - name: "tier_code"
      expr: tier_code
      comment: "Coverage tier code for contribution tier-level analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year contribution strategy became effective for trend analysis."
  measures:
    - name: "avg_contribution_amount"
      expr: AVG(CAST(contribution_amount AS DOUBLE))
      comment: "Average employer contribution dollar amount — benchmarks benefit generosity across employer groups."
    - name: "avg_contribution_percentage"
      expr: AVG(CAST(contribution_percentage AS DOUBLE))
      comment: "Average employer contribution percentage — measures cost-sharing generosity vs. market benchmarks."
    - name: "total_employer_contribution_cap"
      expr: SUM(CAST(employer_contribution_cap AS DOUBLE))
      comment: "Total employer contribution cap dollars — measures maximum benefit funding liability."
    - name: "avg_hra_employer_seed"
      expr: AVG(CAST(hra_employer_seed_amount AS DOUBLE))
      comment: "Average HRA employer seed amount — tracks health reimbursement account funding generosity."
    - name: "avg_hsa_employer_seed"
      expr: AVG(CAST(hsa_employer_seed_amount AS DOUBLE))
      comment: "Average HSA employer seed amount — tracks health savings account funding generosity."
    - name: "avg_max_employee_contribution"
      expr: AVG(CAST(maximum_employee_contribution AS DOUBLE))
      comment: "Average maximum employee contribution cap — measures employee cost burden ceiling."
    - name: "affordability_compliant_count"
      expr: COUNT(CASE WHEN affordability_test_flag = TRUE THEN 1 END)
      comment: "Count of ACA-affordable contribution strategies — ACA employer mandate compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_stop_loss_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop-loss policy metrics tracking attachment points, premium exposure, and risk transfer adequacy for self-funded employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`stop_loss_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Stop-loss policy type (specific, aggregate, combined) for risk transfer strategy analysis."
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Attachment point type for underwriting structure classification."
    - name: "stop_loss_policy_status"
      expr: stop_loss_policy_status
      comment: "Current policy status (active, expired, terminated) for portfolio management."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Stop-loss carrier name for vendor concentration and relationship management."
    - name: "lasering_provision_flag"
      expr: lasering_provision_flag
      comment: "Lasering provision indicator — flags high-risk individual exclusions affecting coverage adequacy."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year policy became effective for vintage and cohort analysis."
  measures:
    - name: "total_stop_loss_premium"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total stop-loss premium paid — measures cost of risk transfer for self-funded employers."
    - name: "avg_individual_attachment_point"
      expr: AVG(CAST(individual_attachment_point AS DOUBLE))
      comment: "Average specific stop-loss attachment point — measures individual claim risk retention level."
    - name: "avg_aggregate_attachment_point"
      expr: AVG(CAST(aggregate_attachment_point AS DOUBLE))
      comment: "Average aggregate stop-loss attachment point — measures total claims risk retention level."
    - name: "total_claim_payment_limit"
      expr: SUM(CAST(claim_payment_limit AS DOUBLE))
      comment: "Total maximum claim payment limit across policies — measures maximum stop-loss recovery potential."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor on stop-loss policies — measures carrier risk loading."
    - name: "total_deductible_exposure"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible exposure across stop-loss policies — measures employer retained risk before coverage."
    - name: "policies_expiring_next_90_days"
      expr: COUNT(CASE WHEN effective_until BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Stop-loss policies expiring within 90 days — renewal pipeline urgency metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker performance and distribution channel metrics tracking commission economics, portfolio quality, and broker relationship health."
  source: "`vibe_health_insurance_v1`.`employer`.`broker`"
  dimensions:
    - name: "broker_type"
      expr: broker_type
      comment: "Broker type (independent, captive, GA) for distribution channel analysis."
    - name: "broker_status"
      expr: broker_status
      comment: "Current broker status (active, terminated, suspended) for channel health monitoring."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Broker agreement status for contract compliance tracking."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Broker agreement renewal status for retention pipeline management."
    - name: "region"
      expr: region
      comment: "Geographic region for distribution channel geographic analysis."
    - name: "state"
      expr: state
      comment: "State of operation for regulatory licensing compliance analysis."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Year broker relationship started for tenure and cohort analysis."
  measures:
    - name: "total_active_brokers"
      expr: COUNT(CASE WHEN broker_status = 'active' THEN 1 END)
      comment: "Total active brokers in distribution network — measures channel capacity and reach."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission dollars paid to brokers — primary distribution cost KPI."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average broker commission rate — benchmarks distribution cost efficiency."
    - name: "avg_broker_rating"
      expr: AVG(CAST(rating AS DOUBLE))
      comment: "Average broker performance rating — measures distribution channel quality."
    - name: "brokers_with_expiring_agreements"
      expr: COUNT(CASE WHEN agreement_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Brokers with agreements expiring in 90 days — retention and contract renewal urgency metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_broker_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker assignment metrics tracking commission economics and broker-group relationship distribution across the employer portfolio."
  source: "`vibe_health_insurance_v1`.`employer`.`broker_assignment`"
  dimensions:
    - name: "broker_assignment_status"
      expr: broker_assignment_status
      comment: "Current assignment status (active, terminated) for active distribution relationship tracking."
    - name: "commission_type"
      expr: commission_type
      comment: "Commission type (flat, percentage, tiered) for compensation structure analysis."
    - name: "commission_basis"
      expr: commission_basis
      comment: "Commission calculation basis (premium, headcount) for cost driver analysis."
    - name: "is_primary"
      expr: is_primary
      comment: "Primary broker flag for identifying lead distribution relationships."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year assignment became effective for tenure analysis."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN broker_assignment_status = 'active' THEN 1 END)
      comment: "Total active broker-group assignments — measures distribution channel coverage."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across broker assignments — tracks distribution cost per group."
    - name: "primary_broker_assignment_count"
      expr: COUNT(CASE WHEN is_primary = TRUE THEN 1 END)
      comment: "Count of primary broker assignments — measures groups with designated primary distribution relationships."
    - name: "distinct_brokers_assigned"
      expr: COUNT(DISTINCT broker_id)
      comment: "Number of distinct brokers with active group assignments — measures distribution network breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_wellness_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program investment, participation, and ROI metrics tracking employer wellness spend and engagement outcomes."
  source: "`vibe_health_insurance_v1`.`employer`.`wellness_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Wellness program type (preventive, chronic disease, mental health) for benefit mix analysis."
    - name: "program_category"
      expr: program_category
      comment: "Program category for portfolio segmentation and investment analysis."
    - name: "wellness_program_status"
      expr: wellness_program_status
      comment: "Current program status (active, ended, pending) for portfolio management."
    - name: "aca_compliance_classification"
      expr: aca_compliance_classification
      comment: "ACA compliance classification for regulatory wellness program categorization."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Mandatory participation flag for program design analysis."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Incentive type (premium discount, gift card, HSA contribution) for engagement strategy analysis."
    - name: "program_effective_year"
      expr: program_effective_year
      comment: "Program effective year for year-over-year investment and participation trend analysis."
  measures:
    - name: "total_program_budget"
      expr: SUM(CAST(program_budget_amount AS DOUBLE))
      comment: "Total wellness program budget committed — measures employer wellness investment level."
    - name: "avg_program_budget"
      expr: AVG(CAST(program_budget_amount AS DOUBLE))
      comment: "Average wellness program budget per program — benchmarks investment per initiative."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive dollars committed across wellness programs — measures engagement investment."
    - name: "avg_actual_participation_pct"
      expr: AVG(CAST(program_actual_participation_pct AS DOUBLE))
      comment: "Average actual participation rate — measures wellness program engagement effectiveness."
    - name: "avg_target_participation_pct"
      expr: AVG(CAST(program_target_participation_pct AS DOUBLE))
      comment: "Average target participation rate — benchmarks participation goals for performance gap analysis."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(program_risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor from wellness programs — measures actuarial impact of wellness on claims."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN wellness_program_status = 'active' THEN 1 END)
      comment: "Count of active wellness programs — measures breadth of wellness benefit offerings."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_tpa_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TPA arrangement metrics tracking administrative fee economics, service scope, and arrangement health for self-funded employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`tpa_arrangement`"
  dimensions:
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "TPA arrangement type (full-service, partial, carve-out) for service scope analysis."
    - name: "tpa_arrangement_status"
      expr: tpa_arrangement_status
      comment: "Current arrangement status (active, terminated, pending) for portfolio management."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA compliance status for regulatory obligation tracking."
    - name: "gfc_control_flag"
      expr: gfc_control_flag
      comment: "GFC control flag for governance and financial control monitoring."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year arrangement became effective for tenure and cohort analysis."
  measures:
    - name: "total_fee_schedule_cap"
      expr: SUM(CAST(fee_schedule_cap_amount AS DOUBLE))
      comment: "Total TPA fee schedule cap dollars — measures maximum administrative cost exposure."
    - name: "avg_fee_schedule_rate_pmpm"
      expr: AVG(CAST(fee_schedule_rate_pmpm AS DOUBLE))
      comment: "Average TPA fee rate per member per month — key administrative cost efficiency benchmark."
    - name: "avg_contribution_rate_pmpm"
      expr: AVG(CAST(contribution_rate_pmpm AS DOUBLE))
      comment: "Average contribution rate PMPM under TPA arrangements — tracks employer funding rate."
    - name: "active_arrangement_count"
      expr: COUNT(CASE WHEN tpa_arrangement_status = 'active' THEN 1 END)
      comment: "Count of active TPA arrangements — measures TPA-administered self-funded group portfolio size."
    - name: "arrangements_renewing_next_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "TPA arrangements renewing within 90 days — operational renewal pipeline urgency metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_aso_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASO fee schedule metrics tracking administrative service fee economics, billing structure, and revenue adequacy for self-funded employer contracts."
  source: "`vibe_health_insurance_v1`.`employer`.`aso_fee_schedule`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "ASO fee component type (claims admin, network access, care management) for revenue attribution."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly) for cash flow and revenue recognition planning."
    - name: "cap_type"
      expr: cap_type
      comment: "Fee cap type for contract structure and revenue ceiling analysis."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Taxability flag for tax liability and compliance analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year fee schedule became effective for revenue trend analysis."
  measures:
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pm_per_member_rate AS DOUBLE))
      comment: "Average per-member-per-month ASO fee rate — primary ASO revenue pricing benchmark."
    - name: "total_cap_amount"
      expr: SUM(CAST(cap_amount AS DOUBLE))
      comment: "Total fee cap amount across ASO schedules — measures maximum ASO revenue ceiling."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate on ASO fees — tracks tax cost burden on administrative revenue."
    - name: "avg_minimum_participation_pct"
      expr: AVG(CAST(minimum_participation_percent AS DOUBLE))
      comment: "Average minimum participation threshold in ASO fee schedules — underwriting requirement compliance."
    - name: "active_fee_schedule_count"
      expr: COUNT(CASE WHEN aso_fee_schedule_status > 0 THEN 1 END)
      comment: "Count of active ASO fee schedules — measures breadth of self-funded administrative service contracts."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_open_enrollment_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open enrollment window metrics tracking participation rates, enrollment activity, and waiver trends across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`open_enrollment_window`"
  dimensions:
    - name: "enrollment_window_type"
      expr: enrollment_window_type
      comment: "Enrollment window type (annual, special, new hire) for enrollment event classification."
    - name: "enrollment_window_status"
      expr: enrollment_window_status
      comment: "Current window status (open, closed, pending) for operational management."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage type offered during enrollment window for benefit mix analysis."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Enrollment method (online, paper, broker-assisted) for channel effectiveness analysis."
    - name: "plan_selection_method"
      expr: plan_selection_method
      comment: "Plan selection method for member decision support analysis."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month enrollment window opened for seasonality and pipeline analysis."
  measures:
    - name: "avg_participation_rate"
      expr: AVG(CAST(participation_rate AS DOUBLE))
      comment: "Average enrollment participation rate across open enrollment windows — primary enrollment effectiveness KPI."
    - name: "total_eligible_employees"
      expr: SUM(CAST(total_employee_count AS DOUBLE))
      comment: "Total eligible employee headcount across enrollment windows — measures enrollment universe size."
    - name: "avg_waiver_allowed_pct"
      expr: AVG(CAST(waiver_allowed AS DOUBLE))
      comment: "Average waiver allowance rate — tracks opt-out trends impacting participation and risk pool composition."
    - name: "active_enrollment_windows"
      expr: COUNT(CASE WHEN enrollment_window_status = 'open' THEN 1 END)
      comment: "Count of currently open enrollment windows — operational workload metric for enrollment teams."
    - name: "windows_closing_next_30_days"
      expr: COUNT(CASE WHEN end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Enrollment windows closing within 30 days — urgency metric for enrollment completion follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_participation_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Participation requirement compliance metrics tracking enrollment thresholds, waiver rates, and underwriting standard adherence across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`participation_requirement`"
  dimensions:
    - name: "requirement_type"
      expr: requirement_type
      comment: "Participation requirement type (minimum enrollment, contribution threshold) for compliance category analysis."
    - name: "participation_requirement_status"
      expr: participation_requirement_status
      comment: "Current compliance status for requirement monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance determination (compliant, non-compliant, waived) for regulatory reporting."
    - name: "funding_arrangement"
      expr: funding_arrangement
      comment: "Funding arrangement for requirement segmentation by product type."
    - name: "erisa_status"
      expr: erisa_status
      comment: "ERISA status for regulatory classification."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating regulatory reporting obligation for compliance tracking."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year requirement became effective for trend analysis."
  measures:
    - name: "avg_participation_percentage"
      expr: AVG(CAST(participation_percentage AS DOUBLE))
      comment: "Average actual participation percentage — measures enrollment compliance against underwriting thresholds."
    - name: "avg_waiver_percentage_allowed"
      expr: AVG(CAST(waiver_percentage_allowed AS DOUBLE))
      comment: "Average waiver percentage allowed — tracks opt-out tolerance in underwriting standards."
    - name: "non_compliant_group_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of groups failing participation requirements — risk indicator for adverse selection and contract termination."
    - name: "compliant_group_count"
      expr: COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END)
      comment: "Count of groups meeting participation requirements — measures underwriting standard adherence."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Count of requirements with regulatory reporting obligations — compliance workload metric."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_group_rating_factor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group rating factor metrics tracking actuarial adjustments, risk loading, and pricing factor composition across employer underwriting cases."
  source: "`vibe_health_insurance_v1`.`employer`.`group_rating_factor`"
  dimensions:
    - name: "actuarial_basis"
      expr: actuarial_basis
      comment: "Actuarial basis for the rating factor for methodology consistency analysis."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for rating factor adjustment for underwriting decision audit."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Flag indicating manual adjustment was applied — tracks underwriting override frequency."
    - name: "is_default"
      expr: is_default
      comment: "Flag indicating default factor was used — measures reliance on standard vs. experience-based pricing."
    - name: "value_unit"
      expr: value_unit
      comment: "Unit of measure for the factor value for dimensional consistency."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year factor became effective for trend analysis."
  measures:
    - name: "avg_factor_value"
      expr: AVG(CAST(factor_value AS DOUBLE))
      comment: "Average rating factor value — measures overall risk loading level applied in underwriting."
    - name: "total_adjusted_factor_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Count of manually adjusted rating factors — measures underwriting override frequency and actuarial consistency."
    - name: "default_factor_usage_count"
      expr: COUNT(CASE WHEN is_default = TRUE THEN 1 END)
      comment: "Count of default factor applications — measures reliance on manual vs. experience-based rating."
    - name: "distinct_groups_rated"
      expr: COUNT(DISTINCT group_id)
      comment: "Number of distinct groups with rating factors applied — measures underwriting pipeline breadth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`employer_regulatory_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employer regulatory compliance metrics tracking obligation status, assessment currency, and remediation needs across employer groups."
  source: "`vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, under-review) for regulatory risk monitoring."
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of regulatory obligation (ACA, ERISA, COBRA, state) for compliance category analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean compliance flag for quick portfolio-level compliance health assessment."
    - name: "last_assessment_date"
      expr: DATE_TRUNC('month', last_assessment_date)
      comment: "Month of last compliance assessment for assessment currency monitoring."
  measures:
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Count of non-compliant regulatory records — primary regulatory risk KPI for employer portfolio."
    - name: "compliant_record_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Count of compliant regulatory records — measures overall compliance health of employer book."
    - name: "assessments_overdue"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE THEN 1 END)
      comment: "Count of overdue compliance assessments — operational risk metric for compliance team workload."
    - name: "distinct_groups_with_compliance_issues"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'non-compliant' THEN group_id END)
      comment: "Number of distinct employer groups with compliance issues — measures breadth of regulatory risk exposure."
$$;