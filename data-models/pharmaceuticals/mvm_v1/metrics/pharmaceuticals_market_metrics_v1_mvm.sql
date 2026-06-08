-- Metric views for domain: market | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_gross_to_net_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks gross-to-net revenue erosion across adjustment types, channels, and payer segments. Core financial KPI for market access and finance leadership to monitor net revenue realization versus gross sales."
  source: "`pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Category of gross-to-net adjustment (e.g., rebate, chargeback, copay assistance, Medicaid) used to segment revenue erosion by type."
    - name: "adjustment_subtype"
      expr: adjustment_subtype
      comment: "Granular sub-classification of the adjustment type for detailed GTN waterfall analysis."
    - name: "channel"
      expr: channel
      comment: "Distribution or sales channel (e.g., retail, specialty, mail order) through which the adjustment was generated."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the adjustment, enabling GTN analysis by disease area portfolio."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the adjustment for annual GTN trend and budget variance reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the adjustment for quarterly GTN performance reviews."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Processing status of the adjustment record (e.g., accrued, settled, disputed) for pipeline and liability tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the adjustment amounts are denominated."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month bucket of the adjustment period start date for time-series trending."
  measures:
    - name: "total_gross_sales_amount"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales (WAC-based) before any GTN deductions. Baseline for net revenue realization calculations."
    - name: "total_net_revenue_amount"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after all GTN adjustments. Primary top-line revenue KPI for market access and finance."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total dollar value of all GTN adjustments. Measures the absolute revenue erosion from gross to net."
    - name: "total_copay_assistance_paid"
      expr: SUM(CAST(copay_assistance_paid_amount AS DOUBLE))
      comment: "Total copay assistance dollars paid out. Key patient access program cost metric monitored by market access leadership."
    - name: "avg_adjustment_rate_pct"
      expr: AVG(CAST(adjustment_rate_pct AS DOUBLE))
      comment: "Average GTN adjustment rate percentage across records. Indicates the typical discount depth being applied."
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS DOUBLE))
      comment: "Total units sold associated with GTN adjustments. Used to compute per-unit net revenue and adjustment rates."
    - name: "disputed_adjustment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN gross_to_net_adjustment_id END)
      comment: "Number of GTN adjustment records under dispute. Elevated counts signal payer reconciliation risk and potential revenue leakage."
    - name: "accrual_record_count"
      expr: COUNT(CASE WHEN accrual_flag = TRUE THEN gross_to_net_adjustment_id END)
      comment: "Number of accrual-basis GTN records. Tracks estimated versus settled liability exposure for close processes."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_rebate_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors rebate claim volumes, amounts, dispute rates, and payment performance across payer contracts and therapeutic areas. Critical for market access finance to manage rebate liability, cash flow, and contract compliance."
  source: "`pharmaceuticals_ecm`.`market`.`rebate_claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of rebate claim (e.g., Medicaid, commercial, Medicare Part D) for segment-level rebate liability analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the rebate claim (e.g., submitted, approved, disputed, paid) for pipeline management."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the rebate claim for portfolio-level rebate burden analysis."
    - name: "rebate_tier"
      expr: rebate_tier
      comment: "Contractual rebate tier achieved, indicating formulary position and performance threshold attainment."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier at time of claim, linking rebate obligation to formulary access level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the rebate claim amounts."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute on the rebate claim, used to track contested liability and resolution timelines."
    - name: "claim_period_start_date"
      expr: DATE_TRUNC('quarter', claim_period_start_date)
      comment: "Quarter bucket of the claim period start date for quarterly rebate accrual and payment trend analysis."
    - name: "medicaid_rebate_flag"
      expr: medicaid_rebate_flag
      comment: "Indicates whether the claim is a Medicaid statutory rebate, enabling mandatory versus voluntary rebate segmentation."
  measures:
    - name: "total_gross_rebate_amount"
      expr: SUM(CAST(gross_rebate_amount AS DOUBLE))
      comment: "Total gross rebate liability across all claims. Primary rebate burden KPI for finance and market access leadership."
    - name: "total_net_rebate_amount"
      expr: SUM(CAST(net_rebate_amount AS DOUBLE))
      comment: "Total net rebate amount after adjustments. Represents actual cash outflow obligation to payers."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar value of disputed rebate claims. Elevated values indicate payer reconciliation risk and potential revenue leakage."
    - name: "total_eligible_units"
      expr: SUM(CAST(eligible_units AS DOUBLE))
      comment: "Total units eligible for rebate across claims. Used to compute per-unit rebate cost and validate claim volumes."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across claims. Benchmarks contractual discount depth and informs pricing strategy."
    - name: "avg_market_share_pct"
      expr: AVG(CAST(market_share_pct AS DOUBLE))
      comment: "Average market share percentage reported on rebate claims. Indicates formulary performance and tier attainment trends."
    - name: "disputed_claim_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status <> 'resolved' THEN rebate_claim_id END)
      comment: "Number of distinct rebate claims with unresolved disputes. Tracks payer reconciliation backlog and financial risk exposure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total prior-period and other adjustments applied to rebate claims. Signals retroactive corrections and accrual accuracy issues."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_pricing_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks pricing decisions across markets, channels, and therapeutic areas. Enables leadership to monitor list price levels, net price realization, gross-to-net spread, and IRP corridor compliance across the global portfolio."
  source: "`pharmaceuticals_ecm`.`market`.`pricing_decision`"
  dimensions:
    - name: "decision_type"
      expr: decision_type
      comment: "Type of pricing decision (e.g., launch price, price increase, IRP adjustment) for categorizing pricing actions."
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the pricing decision (e.g., approved, pending, expired) for pipeline and governance tracking."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the priced product for portfolio-level pricing analysis."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales or distribution channel (e.g., hospital, retail, specialty) for channel-specific pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which pricing decision amounts are expressed."
    - name: "irp_constraint_flag"
      expr: irp_constraint_flag
      comment: "Indicates whether the pricing decision is constrained by international reference pricing, flagging IRP-sensitive markets."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month bucket of the pricing decision effective date for time-series price trend analysis."
    - name: "approving_authority"
      expr: approving_authority
      comment: "Authority that approved the pricing decision (e.g., regulatory body, internal pricing committee) for governance reporting."
  measures:
    - name: "avg_list_price_wac"
      expr: AVG(CAST(list_price_wac AS DOUBLE))
      comment: "Average wholesale acquisition cost (WAC) list price across pricing decisions. Baseline for gross-to-net and IRP analysis."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price after contractual deductions. Measures realized price versus list price across markets."
    - name: "avg_gross_to_net_pct"
      expr: AVG(CAST(gross_to_net_pct AS DOUBLE))
      comment: "Average gross-to-net percentage across pricing decisions. Key indicator of discount depth and net revenue realization."
    - name: "avg_price_change_pct"
      expr: AVG(CAST(price_change_pct AS DOUBLE))
      comment: "Average price change percentage across decisions. Tracks pricing trajectory and inflation/deflation trends in the portfolio."
    - name: "avg_irp_reference_price"
      expr: AVG(CAST(irp_reference_price AS DOUBLE))
      comment: "Average international reference price used in IRP-constrained markets. Informs global launch sequencing and corridor management."
    - name: "irp_constrained_decision_count"
      expr: COUNT(CASE WHEN irp_constraint_flag = TRUE THEN pricing_decision_id END)
      comment: "Number of pricing decisions constrained by IRP. High counts indicate significant cross-market price corridor risk."
    - name: "avg_corridor_breach_threshold_pct"
      expr: AVG(CAST(corridor_breach_threshold_pct AS DOUBLE))
      comment: "Average IRP corridor breach threshold percentage. Used to assess how close current prices are to triggering mandatory IRP adjustments."
    - name: "total_pricing_decisions"
      expr: COUNT(DISTINCT pricing_decision_id)
      comment: "Total number of distinct pricing decisions. Tracks pricing governance activity volume across markets and products."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_coverage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures payer coverage decision outcomes, lives covered, and access restriction patterns across therapeutic areas and payer types. Enables market access leadership to track formulary access breadth and coverage quality."
  source: "`pharmaceuticals_ecm`.`market`.`coverage_decision`"
  dimensions:
    - name: "decision_type"
      expr: decision_type
      comment: "Type of coverage decision (e.g., formulary addition, restriction, exclusion) for access outcome categorization."
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the coverage decision (e.g., approved, pending, appealed) for pipeline tracking."
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (e.g., commercial, Medicaid, Medicare) for segment-level coverage analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the covered product for portfolio-level access analysis."
    - name: "coverage_restriction_type"
      expr: coverage_restriction_type
      comment: "Type of coverage restriction applied (e.g., prior authorization, step therapy, quantity limit) for access barrier analysis."
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy (e.g., first-line, second-line) for which coverage was decided, informing treatment pathway access."
    - name: "reimbursement_scope"
      expr: reimbursement_scope
      comment: "Scope of reimbursement granted (e.g., full, restricted, conditional) for access quality assessment."
    - name: "decision_date"
      expr: DATE_TRUNC('quarter', decision_date)
      comment: "Quarter bucket of the coverage decision date for tracking access decision velocity and trends."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required under this coverage decision, a key access barrier metric."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicates whether step therapy is required, flagging formulary access barriers that delay patient treatment."
  measures:
    - name: "total_lives_covered"
      expr: SUM(CAST(lives_covered AS BIGINT))
      comment: "Total patient lives covered under favorable coverage decisions. Primary market access breadth KPI for leadership."
    - name: "favorable_decision_count"
      expr: COUNT(CASE WHEN decision_status = 'approved' THEN coverage_decision_id END)
      comment: "Number of favorable (approved) coverage decisions. Tracks market access win rate across payers and markets."
    - name: "prior_auth_required_count"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE THEN coverage_decision_id END)
      comment: "Number of coverage decisions requiring prior authorization. High counts indicate access barriers reducing patient uptake."
    - name: "step_therapy_required_count"
      expr: COUNT(CASE WHEN step_therapy_required = TRUE THEN coverage_decision_id END)
      comment: "Number of coverage decisions requiring step therapy. Tracks formulary access barriers that delay first-line treatment."
    - name: "rwe_required_count"
      expr: COUNT(CASE WHEN rwe_required_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of coverage decisions requiring real-world evidence. Signals payer demand for post-approval evidence generation."
    - name: "managed_entry_agreement_count"
      expr: COUNT(CASE WHEN managed_entry_agreement_flag = TRUE THEN coverage_decision_id END)
      comment: "Number of coverage decisions with managed entry agreements. Indicates risk-sharing arrangements with payers."
    - name: "total_coverage_decisions"
      expr: COUNT(DISTINCT coverage_decision_id)
      comment: "Total distinct coverage decisions across all payers and markets. Baseline volume metric for access activity tracking."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_formulary_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks formulary tier positions, rebate commitments, lives covered, and access restrictions across payers and therapeutic areas. Enables market access teams to monitor formulary access quality and rebate investment efficiency."
  source: "`pharmaceuticals_ecm`.`market`.`formulary_position`"
  dimensions:
    - name: "formulary_position_code"
      expr: formulary_position_code
      comment: "Formulary position code (e.g., preferred, non-preferred, excluded) indicating the access tier achieved."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the formulary-listed product for portfolio-level access analysis."
    - name: "payer_segment"
      expr: payer_segment
      comment: "Payer segment (e.g., commercial, Medicaid, Medicare) for segment-level formulary access analysis."
    - name: "rebate_tier"
      expr: rebate_tier
      comment: "Rebate tier associated with the formulary position, linking access level to rebate investment."
    - name: "plan_year"
      expr: plan_year
      comment: "Plan year of the formulary position for annual access trend and contract cycle analysis."
    - name: "specialty_drug_flag"
      expr: specialty_drug_flag
      comment: "Indicates whether the formulary position is for a specialty drug, enabling specialty vs. traditional formulary analysis."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Indicates whether prior authorization is required at this formulary position, a key access barrier dimension."
    - name: "step_therapy_required"
      expr: step_therapy_required
      comment: "Indicates whether step therapy is required at this formulary position."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month bucket of the formulary position effective date for time-series access trend analysis."
  measures:
    - name: "total_lives_covered"
      expr: SUM(CAST(lives_covered AS BIGINT))
      comment: "Total patient lives covered at this formulary position. Primary market access breadth KPI — higher lives at preferred tiers indicates strong access."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage committed to achieve formulary position. Measures rebate investment depth per access tier."
    - name: "avg_market_share_impact_pct"
      expr: AVG(CAST(market_share_impact_pct AS DOUBLE))
      comment: "Average estimated market share impact from formulary position. Quantifies the revenue value of formulary access investments."
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average patient copay amount at this formulary position. Lower copays indicate better patient affordability and adherence potential."
    - name: "avg_coinsurance_rate"
      expr: AVG(CAST(coinsurance_rate AS DOUBLE))
      comment: "Average coinsurance rate at this formulary position. Tracks patient out-of-pocket burden across payer tiers."
    - name: "preferred_position_lives"
      expr: SUM(CASE WHEN formulary_position_code = 'preferred' THEN CAST(lives_covered AS BIGINT) ELSE 0 END)
      comment: "Total lives covered at preferred formulary tier. Strategic KPI for market access — preferred coverage drives volume and reduces access barriers."
    - name: "restricted_position_count"
      expr: COUNT(CASE WHEN prior_authorization_required = TRUE OR step_therapy_required = TRUE THEN formulary_position_id END)
      comment: "Number of formulary positions with access restrictions (PA or step therapy). Tracks the breadth of unrestricted access across the payer landscape."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_payer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors payer contract terms, rebate commitments, book-of-business coverage, and contract performance across the payer portfolio. Enables market access and finance leadership to manage contract value, renewal risk, and rebate liability."
  source: "`pharmaceuticals_ecm`.`market`.`payer_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of payer contract (e.g., rebate, value-based, fee-for-service) for contract portfolio segmentation."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g., active, expired, in negotiation) for contract lifecycle management."
    - name: "formulary_tier"
      expr: formulary_tier
      comment: "Formulary tier secured under the contract, linking contract terms to access outcomes."
    - name: "performance_metric_type"
      expr: performance_metric_type
      comment: "Type of performance metric governing incremental rebate triggers (e.g., market share, outcomes) for value-based contract analysis."
    - name: "rebate_payment_frequency"
      expr: rebate_payment_frequency
      comment: "Frequency of rebate payments (e.g., quarterly, annually) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of contract financial terms."
    - name: "most_favored_nation_clause"
      expr: most_favored_nation_clause
      comment: "Indicates presence of MFN clause, which constrains pricing flexibility across markets."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year bucket of contract effective start date for contract vintage and renewal cycle analysis."
    - name: "value_based_contract_flag"
      expr: CASE WHEN performance_metric_type IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Derived flag indicating whether the contract includes value-based or outcomes-linked performance terms."
  measures:
    - name: "total_book_of_business_lives"
      expr: SUM(CAST(book_of_business_lives AS BIGINT))
      comment: "Total patient lives covered across all payer contracts. Measures the breadth of contracted market access."
    - name: "total_estimated_annual_rebate"
      expr: SUM(CAST(estimated_annual_rebate_amount AS DOUBLE))
      comment: "Total estimated annual rebate obligation across all contracts. Primary rebate liability KPI for finance and market access."
    - name: "avg_base_rebate_pct"
      expr: AVG(CAST(base_rebate_pct AS DOUBLE))
      comment: "Average base rebate percentage across contracts. Benchmarks the baseline discount depth committed to payers."
    - name: "avg_incremental_rebate_pct"
      expr: AVG(CAST(incremental_rebate_pct AS DOUBLE))
      comment: "Average incremental (performance) rebate percentage. Measures the additional rebate at risk under value-based contract terms."
    - name: "avg_price_protection_threshold_pct"
      expr: AVG(CAST(price_protection_threshold_pct AS DOUBLE))
      comment: "Average price protection threshold percentage across contracts. Indicates how much price flexibility is constrained by contract terms."
    - name: "mfn_contract_count"
      expr: COUNT(CASE WHEN most_favored_nation_clause = TRUE THEN payer_contract_id END)
      comment: "Number of contracts with MFN clauses. High counts signal significant pricing constraint risk across the payer portfolio."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN payer_contract_id END)
      comment: "Number of currently active payer contracts. Baseline for contracted market coverage and renewal pipeline management."
    - name: "avg_admin_fee_pct"
      expr: AVG(CAST(admin_fee_pct AS DOUBLE))
      comment: "Average administrative fee percentage charged by payers. Tracks contract overhead costs impacting net revenue."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_hta_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks HTA submission outcomes, ICER values, reimbursement conditions, and submission timelines across markets and therapeutic areas. Enables market access and HEOR leadership to monitor HTA success rates and evidence package effectiveness."
  source: "`pharmaceuticals_ecm`.`market`.`hta_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the HTA submission (e.g., submitted, under review, decided) for pipeline tracking."
    - name: "decision_type"
      expr: decision_type
      comment: "Type of HTA decision outcome (e.g., positive, negative, conditional) for success rate analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the submitted product for portfolio-level HTA performance analysis."
    - name: "hta_body_code"
      expr: hta_body_code
      comment: "Code identifying the HTA body (e.g., NICE, G-BA, HAS) for country/agency-level submission analysis."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of HTA submission (e.g., initial, re-submission, extension) for submission strategy analysis."
    - name: "economic_model_type"
      expr: economic_model_type
      comment: "Type of economic model used (e.g., cost-effectiveness, budget impact) for evidence strategy benchmarking."
    - name: "benefit_rating"
      expr: benefit_rating
      comment: "HTA body benefit rating assigned (e.g., major, moderate, minor, no added benefit) for outcome quality tracking."
    - name: "rwe_required"
      expr: rwe_required
      comment: "Indicates whether real-world evidence was required by the HTA body, tracking evidence generation demand."
    - name: "planned_submission_date"
      expr: DATE_TRUNC('quarter', planned_submission_date)
      comment: "Quarter bucket of planned submission date for submission pipeline and timeline management."
  measures:
    - name: "avg_icer_submitted"
      expr: AVG(CAST(icer_submitted AS DOUBLE))
      comment: "Average ICER value submitted to HTA bodies. Key HEOR KPI — values above willingness-to-pay thresholds risk negative decisions."
    - name: "avg_willingness_to_pay_threshold"
      expr: AVG(CAST(willingness_to_pay_threshold AS DOUBLE))
      comment: "Average willingness-to-pay threshold across HTA submissions. Benchmarks ICER headroom and reimbursement feasibility."
    - name: "avg_recommended_price_lower"
      expr: AVG(CAST(recommended_price_lower AS DOUBLE))
      comment: "Average lower bound of HTA-recommended reimbursement price. Informs pricing corridor and negotiation floor."
    - name: "avg_recommended_price_upper"
      expr: AVG(CAST(recommended_price_upper AS DOUBLE))
      comment: "Average upper bound of HTA-recommended reimbursement price. Informs pricing ceiling and negotiation range."
    - name: "positive_decision_count"
      expr: COUNT(CASE WHEN decision_type = 'positive' THEN hta_submission_id END)
      comment: "Number of HTA submissions with positive reimbursement decisions. Primary HTA success rate numerator for market access KPIs."
    - name: "appeal_filed_count"
      expr: COUNT(CASE WHEN appeal_filed = TRUE THEN hta_submission_id END)
      comment: "Number of HTA submissions where an appeal was filed. High counts indicate evidence package quality issues or aggressive HTA body positions."
    - name: "managed_access_scheme_count"
      expr: COUNT(CASE WHEN managed_access_scheme = TRUE THEN hta_submission_id END)
      comment: "Number of submissions resulting in managed access schemes. Indicates conditional reimbursement arrangements requiring ongoing evidence generation."
    - name: "total_hta_submissions"
      expr: COUNT(DISTINCT hta_submission_id)
      comment: "Total distinct HTA submissions. Baseline volume metric for HTA pipeline activity and resource planning."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_access_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks market access strategy execution across products, indications, and countries. Enables market access leadership to monitor launch readiness, HTA strategy alignment, list price positioning, and GTN target performance."
  source: "`pharmaceuticals_ecm`.`market`.`access_strategy`"
  dimensions:
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of access strategy (e.g., value-based, outcomes-linked, standard) for strategic approach segmentation."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the access strategy (e.g., planning, active, closed) for pipeline management."
    - name: "payer_segment"
      expr: payer_segment
      comment: "Target payer segment for the access strategy, enabling segment-level strategy coverage analysis."
    - name: "hta_body_code"
      expr: hta_body_code
      comment: "HTA body targeted by the access strategy for country/agency-level strategy alignment analysis."
    - name: "hta_outcome"
      expr: hta_outcome
      comment: "Achieved HTA outcome for the strategy, enabling retrospective success rate analysis."
    - name: "reimbursement_pathway"
      expr: reimbursement_pathway
      comment: "Reimbursement pathway pursued (e.g., standard, accelerated, conditional) for pathway strategy analysis."
    - name: "target_formulary_tier"
      expr: target_formulary_tier
      comment: "Target formulary tier the strategy aims to achieve, for access ambition benchmarking."
    - name: "actual_launch_date"
      expr: DATE_TRUNC('quarter', actual_launch_date)
      comment: "Quarter bucket of actual product launch date for launch timeline and delay analysis."
    - name: "copay_assistance_flag"
      expr: copay_assistance_flag
      comment: "Indicates whether copay assistance is part of the access strategy, tracking patient affordability program deployment."
  measures:
    - name: "avg_list_price_amount"
      expr: AVG(CAST(list_price_amount AS DOUBLE))
      comment: "Average list price across access strategies. Benchmarks pricing ambition and informs GTN waterfall analysis."
    - name: "avg_gross_to_net_target_pct"
      expr: AVG(CAST(gross_to_net_target_pct AS DOUBLE))
      comment: "Average GTN target percentage across strategies. Tracks planned discount depth versus actual GTN realization."
    - name: "avg_icer_threshold_amount"
      expr: AVG(CAST(icer_threshold_amount AS DOUBLE))
      comment: "Average ICER threshold used in access strategy planning. Benchmarks cost-effectiveness positioning across therapeutic areas."
    - name: "launch_delay_strategy_count"
      expr: COUNT(CASE WHEN actual_launch_date > planned_launch_date THEN access_strategy_id END)
      comment: "Number of strategies where actual launch date exceeded planned launch date. Tracks launch execution risk and market access delays."
    - name: "patient_support_program_count"
      expr: COUNT(CASE WHEN patient_support_program_flag = TRUE THEN access_strategy_id END)
      comment: "Number of access strategies with patient support programs. Tracks patient-centric access investment across the portfolio."
    - name: "active_strategy_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN access_strategy_id END)
      comment: "Number of currently active access strategies. Baseline for market access pipeline capacity and resource planning."
    - name: "total_access_strategies"
      expr: COUNT(DISTINCT access_strategy_id)
      comment: "Total distinct access strategies across all products and markets. Tracks overall market access program scope."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_patient_access_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors patient access program budgets, benefit structures, and enrollment eligibility across therapeutic areas and payer segments. Enables market access and patient advocacy leadership to track program investment, reach, and compliance."
  source: "`pharmaceuticals_ecm`.`market`.`patient_access_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of patient access program (e.g., copay assistance, free drug, hub services) for program portfolio segmentation."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the program (e.g., active, suspended, closed) for program lifecycle management."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area served by the program for portfolio-level patient access investment analysis."
    - name: "payer_segment"
      expr: payer_segment
      comment: "Target payer segment for the program, enabling segment-level access gap analysis."
    - name: "benefit_type"
      expr: benefit_type
      comment: "Type of benefit provided (e.g., financial assistance, clinical support, adherence) for program value analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of program funding (e.g., manufacturer, foundation, government) for financial accountability."
    - name: "rems_program_flag"
      expr: rems_program_flag
      comment: "Indicates whether the program is a REMS (Risk Evaluation and Mitigation Strategy) program, flagging regulatory-mandated access programs."
    - name: "line_of_therapy"
      expr: line_of_therapy
      comment: "Line of therapy supported by the program for treatment pathway access analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year bucket of program effective start date for program vintage and investment trend analysis."
  measures:
    - name: "total_annual_program_budget"
      expr: SUM(CAST(annual_program_budget AS DOUBLE))
      comment: "Total annual budget committed across all patient access programs. Primary patient access investment KPI for leadership."
    - name: "avg_annual_program_budget"
      expr: AVG(CAST(annual_program_budget AS DOUBLE))
      comment: "Average annual budget per patient access program. Benchmarks program investment levels across therapeutic areas."
    - name: "total_benefit_cap_amount"
      expr: SUM(CAST(benefit_cap_amount AS DOUBLE))
      comment: "Total benefit cap amount across programs. Measures the maximum patient assistance liability exposure."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'active' THEN patient_access_program_id END)
      comment: "Number of currently active patient access programs. Tracks the breadth of patient support infrastructure across the portfolio."
    - name: "rems_program_count"
      expr: COUNT(CASE WHEN rems_program_flag = TRUE THEN patient_access_program_id END)
      comment: "Number of REMS programs. Tracks regulatory-mandated access program compliance obligations."
    - name: "income_threshold_program_count"
      expr: COUNT(CASE WHEN income_threshold_required = TRUE THEN patient_access_program_id END)
      comment: "Number of programs with income eligibility thresholds. Indicates means-tested access program scope for patient affordability analysis."
    - name: "specialty_pharmacy_required_count"
      expr: COUNT(CASE WHEN specialty_pharmacy_required = TRUE THEN patient_access_program_id END)
      comment: "Number of programs requiring specialty pharmacy distribution. Tracks specialty channel dependency and associated access complexity."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`market_payer_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks payer engagement activity, outcomes, and follow-up completion across therapeutic areas and engagement types. Enables market access teams to monitor payer relationship quality, negotiation progress, and evidence presentation effectiveness."
  source: "`pharmaceuticals_ecm`.`market`.`payer_engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of payer engagement (e.g., formulary committee meeting, contract negotiation, medical education) for activity segmentation."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the engagement (e.g., completed, scheduled, cancelled) for pipeline and activity tracking."
    - name: "engagement_outcome"
      expr: engagement_outcome
      comment: "Outcome of the engagement (e.g., positive, neutral, negative) for win rate and relationship quality analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area discussed in the engagement for portfolio-level payer relationship analysis."
    - name: "engagement_channel"
      expr: engagement_channel
      comment: "Channel of engagement (e.g., in-person, virtual, written) for channel effectiveness analysis."
    - name: "negotiation_stage"
      expr: negotiation_stage
      comment: "Stage of contract negotiation at time of engagement for pipeline progression tracking."
    - name: "engagement_date"
      expr: DATE_TRUNC('quarter', engagement_date)
      comment: "Quarter bucket of engagement date for activity volume and trend analysis."
    - name: "heor_evidence_presented_flag"
      expr: heor_evidence_presented_flag
      comment: "Indicates whether HEOR evidence was presented during the engagement, tracking evidence utilization in payer interactions."
  measures:
    - name: "total_engagements"
      expr: COUNT(DISTINCT payer_engagement_id)
      comment: "Total distinct payer engagements. Baseline activity volume metric for market access team productivity and payer coverage."
    - name: "positive_outcome_count"
      expr: COUNT(CASE WHEN engagement_outcome = 'positive' THEN payer_engagement_id END)
      comment: "Number of engagements with positive outcomes. Tracks payer relationship quality and negotiation success rate."
    - name: "follow_up_completed_count"
      expr: COUNT(CASE WHEN follow_up_completed = TRUE THEN payer_engagement_id END)
      comment: "Number of engagements with completed follow-up actions. Measures execution discipline and commitment fulfillment in payer relationships."
    - name: "heor_evidence_presented_count"
      expr: COUNT(CASE WHEN heor_evidence_presented_flag = TRUE THEN payer_engagement_id END)
      comment: "Number of engagements where HEOR evidence was presented. Tracks evidence-based selling activity and HEOR asset utilization."
    - name: "rebate_discussed_count"
      expr: COUNT(CASE WHEN rebate_discussed_flag = TRUE THEN payer_engagement_id END)
      comment: "Number of engagements where rebate terms were discussed. Tracks contract negotiation activity intensity across the payer portfolio."
    - name: "outcomes_contract_discussed_count"
      expr: COUNT(CASE WHEN outcomes_contract_discussed_flag = TRUE THEN payer_engagement_id END)
      comment: "Number of engagements where outcomes-based contracts were discussed. Tracks value-based contracting pipeline development activity."
    - name: "overdue_follow_up_count"
      expr: COUNT(CASE WHEN follow_up_completed = FALSE AND follow_up_due_date < CURRENT_DATE() THEN payer_engagement_id END)
      comment: "Number of engagements with overdue follow-up actions. Operational risk KPI — overdue commitments damage payer relationships and negotiation credibility."
$$;