-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the client account master — tracks portfolio health, credit exposure, revenue potential, and prequalification standing across the client base."
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (e.g. Active, Inactive, Suspended) — primary filter for active portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Owner, Developer, Government) — used to segment revenue and credit exposure by client type."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier assigned to the client (e.g. Tier 1, Tier 2) — drives relationship investment and prioritisation decisions."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client — enables sector-level pipeline and revenue analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the account — supports geographic segmentation of the client portfolio."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating of the account — used to assess credit risk concentration across the portfolio."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification standing of the account — determines eligibility for bid and tender participation."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Client's preferred contract delivery model — informs commercial strategy and contract structuring."
    - name: "hse_compliance_required"
      expr: hse_compliance_required
      comment: "Flag indicating whether HSE compliance is mandated for this account — used in risk and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency of the account — required for multi-currency portfolio aggregation."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced — supports client tenure cohort analysis."
    - name: "last_project_award_year"
      expr: YEAR(last_project_award_date)
      comment: "Year of the most recent project award — identifies recently active vs dormant clients."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Count of active client accounts — baseline measure of the live client portfolio size."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all client accounts — proxy for total addressable market value of the client base."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account — benchmarks client size and informs tiering decisions."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — measures aggregate credit risk exposure in the portfolio."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — used to benchmark credit policy consistency and identify outliers."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_rating = 'Hold' THEN account_id END)
      comment: "Number of accounts flagged with a hold credit rating — early warning indicator for collections and credit risk management."
    - name: "prequalified_account_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN account_id END)
      comment: "Count of accounts with approved prequalification status — determines the eligible bidder pool for upcoming tenders."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average contractual payment terms (days) across accounts — informs cash flow forecasting and working capital planning."
    - name: "hse_compliant_account_count"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN account_id END)
      comment: "Count of accounts requiring HSE compliance — supports regulatory and safety governance reporting."
    - name: "jv_entity_account_count"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN account_id END)
      comment: "Count of accounts that are joint venture entities — tracks JV partnership exposure in the client portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — tracks bid activity, win rates, weighted pipeline value, and strategic opportunity conversion across the construction sales funnel."
  source: "`vibe_construction_v1`.`client`.`opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity (e.g. Open, Won, Lost, Withdrawn) — primary filter for pipeline vs closed analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage of the opportunity in the sales pipeline — enables funnel conversion analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. Civil, Building, Infrastructure) — segments pipeline by work type."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the opportunity — supports sector-level pipeline and win-rate analysis."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project is located — enables geographic pipeline analysis."
    - name: "project_location_region"
      expr: project_location_region
      comment: "Region where the project is located — supports regional business development performance tracking."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (e.g. D&C, EPC, Alliance) — informs commercial strategy and risk profiling."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Outcome of the bid/no-bid decision gate — tracks bid selectivity and resource allocation discipline."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final win/loss outcome of the opportunity — used in win-rate and loss-reason analysis."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity — ensures high-priority bids receive appropriate resource focus."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Flag indicating whether the bid is a joint venture — tracks JV bid strategy and partnership activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity value — required for multi-currency pipeline aggregation."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the award is expected — supports forward pipeline scheduling and resource planning."
    - name: "bid_submission_year"
      expr: YEAR(bid_submission_date)
      comment: "Year the bid was submitted — enables year-over-year bid activity trending."
  measures:
    - name: "total_pipeline_opportunities"
      expr: COUNT(opportunity_id)
      comment: "Total number of opportunities in the pipeline — baseline measure of business development activity volume."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities — measures total gross pipeline value available to the business."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values — the primary risk-adjusted pipeline metric used in revenue forecasting and board reporting."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability across open opportunities — indicates overall pipeline quality and bid competitiveness."
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of preparing bids — measures business development investment and cost-of-pursuit efficiency."
    - name: "avg_bid_cost_estimate"
      expr: AVG(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Average bid preparation cost per opportunity — benchmarks pursuit cost efficiency across project types and sectors."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN opportunity_id END)
      comment: "Count of won opportunities — numerator for win rate calculation and measure of BD conversion success."
    - name: "lost_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN opportunity_id END)
      comment: "Count of lost opportunities — used in win/loss ratio analysis and loss-reason investigation."
    - name: "total_won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated contract value of won opportunities — measures revenue secured through the BD pipeline."
    - name: "avg_project_duration_months"
      expr: AVG(CAST(project_duration_months AS DOUBLE))
      comment: "Average project duration in months across opportunities — informs resource planning and backlog duration forecasting."
    - name: "jv_bid_count"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN opportunity_id END)
      comment: "Count of opportunities pursued as joint ventures — tracks JV strategy execution and partnership pipeline."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated opportunity value — benchmarks deal size trends and informs minimum bid threshold decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and receivables KPIs for the client credit portfolio — tracks credit exposure, overdue balances, DSO performance, and credit hold concentration to support treasury and risk management decisions."
  source: "`vibe_construction_v1`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (e.g. Active, Expired, Under Review) — primary filter for live credit exposure analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating assigned to the client — used to segment credit exposure by risk band."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External agency credit rating — cross-validates internal ratings and supports independent risk assessment."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Name of the external credit rating agency — tracks which agency ratings are in use across the portfolio."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment classification — enables credit risk analysis by strategic client tier."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean flag indicating the account is on credit hold — critical filter for collections and risk escalation workflows."
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Flag indicating credit insurance is in place — used to assess net vs gross credit exposure."
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Flag indicating sovereign risk exposure — supports country risk concentration reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile — required for multi-currency credit exposure aggregation."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "Frequency of scheduled credit reviews — supports governance compliance and review cycle management."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the credit profile became effective — supports vintage analysis of credit decisions."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total approved credit limit across all active profiles — measures aggregate credit exposure ceiling for the portfolio."
    - name: "total_current_exposure_amount"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current credit exposure across all profiles — the primary measure of live credit risk in the portfolio."
    - name: "total_overdue_balance_amount"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue receivables balance across all client credit profiles — key collections and cash flow risk indicator."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across the credit portfolio — measures receivables collection efficiency and working capital performance."
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance coverage in place — measures the insured portion of credit exposure for net risk calculation."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across credit profiles — quantifies contractual penalty risk in the client portfolio."
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN account_credit_profile_id END)
      comment: "Number of client credit profiles currently on credit hold — measures the scale of credit risk escalation requiring management action."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average approved payment terms in days across credit profiles — benchmarks commercial payment terms consistency."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across client credit profiles — informs cash flow planning and retention release scheduling."
    - name: "total_retention_exposure"
      expr: SUM(CAST(retention_percentage AS DOUBLE))
      comment: "Sum of retention percentages across all profiles — aggregate measure of retention policy application across the portfolio."
    - name: "avg_payment_history_rating"
      expr: AVG(CAST(payment_history_rating AS DOUBLE))
      comment: "Average payment history rating score across clients — composite indicator of portfolio-wide payment behaviour quality."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement KPIs — tracks contract value, retention, satisfaction, variation exposure, and engagement health across all active and historical client project relationships."
  source: "`vibe_construction_v1`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement (e.g. Active, Completed, Terminated) — primary filter for live vs historical analysis."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of client engagement (e.g. Head Contract, Subcontract, Alliance) — segments contract value by delivery model."
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement (e.g. Principal, Developer, Funder) — supports relationship type analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the project engagement — enables sector-level revenue and satisfaction analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Lump Sum, GMP, Cost Plus) — informs commercial risk and margin analysis by contract type."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Strategic relationship tier of the client engagement — prioritises account management effort and investment."
    - name: "repeat_client"
      expr: repeat_client
      comment: "Flag indicating whether the client is a repeat client — measures client retention and loyalty."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status of the engagement — identifies engagements requiring legal or commercial intervention."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. Government, Private, PPP) — supports funding-type portfolio analysis."
    - name: "hse_requirements_classification"
      expr: hse_requirements_classification
      comment: "HSE risk classification of the engagement — supports safety governance and compliance reporting."
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract — required for multi-currency contract value aggregation."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the engagement commenced — supports year-over-year contract award and backlog trend analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all client project engagements — primary measure of revenue backlog and client portfolio value."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per engagement — benchmarks deal size and informs minimum project threshold decisions."
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total value of approved contract variations — measures scope growth and commercial change management performance."
    - name: "avg_variation_to_contract_ratio"
      expr: AVG(CAST(approved_variation_value AS DOUBLE) / NULLIF(CAST(contract_value AS DOUBLE), 0))
      comment: "Average ratio of approved variations to original contract value — indicates scope creep tendency and commercial risk per engagement."
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments made to clients — measures upfront cash outflow and advance payment risk exposure."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across engagements — the primary client experience KPI used in relationship management and NPS-equivalent reporting."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across engagements — informs cash flow planning and retention release scheduling."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements — measures contractual penalty exposure and risk profile of the portfolio."
    - name: "repeat_client_engagement_count"
      expr: COUNT(CASE WHEN repeat_client = TRUE THEN project_engagement_id END)
      comment: "Count of engagements with repeat clients — measures client retention success and relationship stickiness."
    - name: "active_engagement_count"
      expr: COUNT(CASE WHEN engagement_status = 'Active' THEN project_engagement_id END)
      comment: "Count of currently active client project engagements — measures live workload and active relationship volume."
    - name: "avg_jv_participation_percentage"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average JV participation percentage across engagements — measures the firm's equity stake in joint venture projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement portfolio KPIs — tracks ceiling value, committed value, utilisation, and agreement health across all client framework and panel arrangements."
  source: "`vibe_construction_v1`.`client`.`framework_agreement`"
  dimensions:
    - name: "client_framework_agreement_status"
      expr: client_framework_agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Terminated) — primary filter for live vs historical agreement analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (e.g. Panel, Alliance, Master Services) — segments portfolio by commercial arrangement type."
    - name: "sector"
      expr: sector
      comment: "Industry sector covered by the agreement — enables sector-level framework portfolio analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region covered by the agreement — supports regional framework coverage analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the framework agreement — enables country-level portfolio segmentation."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model specified in the agreement (e.g. D&C, EPC, Managing Contractor) — informs commercial strategy analysis."
    - name: "procurement_route"
      expr: procurement_route
      comment: "Procurement route used to establish the agreement — tracks procurement method effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the framework agreement — required for multi-currency value aggregation."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective — supports vintage and renewal cycle analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires — critical for renewal pipeline planning and revenue continuity management."
  measures:
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Total ceiling value across all framework agreements — measures the maximum revenue addressable through framework arrangements."
    - name: "total_committed_value"
      expr: SUM(CAST(committed_value AS DOUBLE))
      comment: "Total committed (called-off) value across framework agreements — measures revenue already secured under framework arrangements."
    - name: "avg_framework_utilisation_rate"
      expr: AVG(CAST(committed_value AS DOUBLE) / NULLIF(CAST(ceiling_value AS DOUBLE), 0))
      comment: "Average utilisation rate of framework agreements (committed / ceiling) — measures how effectively framework capacity is being converted to revenue."
    - name: "avg_duration_months"
      expr: AVG(CAST(duration_months AS DOUBLE))
      comment: "Average duration of framework agreements in months — informs long-term revenue visibility and relationship stability."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage specified in framework agreements — informs cash flow planning across the framework portfolio."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across framework agreements — measures contractual penalty risk embedded in the framework portfolio."
    - name: "active_framework_count"
      expr: COUNT(CASE WHEN client_framework_agreement_status = 'Active' THEN framework_agreement_id END)
      comment: "Count of currently active framework agreements — measures the live framework pipeline and relationship coverage."
    - name: "avg_max_calloff_value"
      expr: AVG(CAST(max_calloff_value AS DOUBLE))
      comment: "Average maximum call-off value per framework agreement — benchmarks individual project size limits within framework arrangements."
    - name: "total_extension_duration_months"
      expr: SUM(CAST(extension_duration_months AS DOUBLE))
      comment: "Total extension duration months available across agreements — measures the potential revenue runway from agreement extensions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement and relationship activity KPIs — tracks interaction volume, sentiment, executive engagement, and entertainment spend to measure relationship health and BD activity intensity."
  source: "`vibe_construction_v1`.`client`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of client interaction (e.g. Meeting, Call, Site Visit, Entertainment) — segments engagement activity by channel and format."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g. Completed, Planned, Cancelled) — filters for completed vs planned engagement activity."
    - name: "channel"
      expr: channel
      comment: "Communication channel used (e.g. In-Person, Video, Phone) — tracks channel mix for client engagement strategy."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (e.g. Positive, Neutral, Negative) — measures interaction effectiveness and relationship progression."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Sentiment indicator recorded for the interaction — tracks relationship health trends over time."
    - name: "client_seniority_level"
      expr: client_seniority_level
      comment: "Seniority level of the client contact engaged — measures executive engagement depth and relationship quality."
    - name: "is_executive_engagement"
      expr: is_executive_engagement
      comment: "Flag indicating executive-level engagement — tracks C-suite relationship investment and access."
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the interaction (e.g. Relationship Building, Bid Discussion, Issue Resolution) — segments activity by strategic intent."
    - name: "interaction_year"
      expr: YEAR(interaction_date)
      comment: "Year of the interaction — supports year-over-year engagement activity trending."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction — enables monthly engagement cadence and seasonality analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(interaction_id)
      comment: "Total number of client interactions — baseline measure of BD and relationship management activity volume."
    - name: "total_interaction_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total time invested in client interactions (minutes) — measures relationship management effort and time-to-client investment."
    - name: "avg_interaction_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of client interactions in minutes — benchmarks engagement depth and meeting quality."
    - name: "total_entertainment_cost"
      expr: SUM(CAST(entertainment_cost AS DOUBLE))
      comment: "Total client entertainment expenditure — measures BD hospitality spend for budget control and gifts/hospitality compliance reporting."
    - name: "avg_entertainment_cost_per_interaction"
      expr: AVG(CAST(entertainment_cost AS DOUBLE))
      comment: "Average entertainment cost per interaction — benchmarks hospitality spend efficiency and policy compliance."
    - name: "executive_engagement_count"
      expr: COUNT(CASE WHEN is_executive_engagement = TRUE THEN interaction_id END)
      comment: "Count of executive-level client interactions — measures C-suite relationship investment and strategic access frequency."
    - name: "followup_completion_count"
      expr: COUNT(CASE WHEN followup_completed = TRUE THEN interaction_id END)
      comment: "Count of interactions where follow-up actions were completed — measures BD team responsiveness and action closure rate."
    - name: "gifts_hospitality_declared_count"
      expr: COUNT(CASE WHEN gifts_hospitality_declared = TRUE THEN interaction_id END)
      comment: "Count of interactions with declared gifts or hospitality — supports anti-bribery compliance and gifts register governance."
    - name: "distinct_accounts_engaged"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of distinct client accounts engaged — measures breadth of active relationship management across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prequalification programme KPIs — tracks approval rates, scoring performance, TRIR compliance, and expiry pipeline to manage the eligible bidder pool and supply chain qualification governance."
  source: "`vibe_construction_v1`.`client`.`prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current status of the prequalification (e.g. Approved, Rejected, Expired, Under Review) — primary filter for eligible vs ineligible supplier analysis."
    - name: "work_category"
      expr: work_category
      comment: "Category of work the prequalification covers — segments the qualified supplier pool by trade and work type."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category of the prequalification — enables category-level qualification coverage analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the prequalification — supports geographic qualification coverage analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the prequalification — identifies regional coverage of the qualified supplier pool."
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Flag indicating HSE certification is required — tracks HSE compliance gate in the qualification process."
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Flag indicating eligibility for RFP participation — measures the size of the qualified RFP bidder pool."
    - name: "rfq_eligibility_flag"
      expr: rfq_eligibility_flag
      comment: "Flag indicating eligibility for RFQ participation — measures the size of the qualified RFQ bidder pool."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of prequalification approval — supports vintage analysis of the qualified supplier pool."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of prequalification expiry — critical for renewal pipeline planning and qualification gap management."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(prequalification_id)
      comment: "Total number of prequalification records — baseline measure of qualification programme activity volume."
    - name: "approved_prequalification_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN prequalification_id END)
      comment: "Count of approved prequalifications — measures the size of the currently eligible bidder pool."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score across all assessments — benchmarks overall supplier quality and qualification standard."
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate submitted by applicants — measures safety performance of the qualified supplier pool."
    - name: "trir_threshold_exceedance_count"
      expr: COUNT(CASE WHEN CAST(submitted_trir AS DOUBLE) > CAST(trir_threshold AS DOUBLE) THEN prequalification_id END)
      comment: "Count of prequalifications where submitted TRIR exceeds the threshold — identifies suppliers failing the safety performance gate."
    - name: "avg_max_project_value"
      expr: AVG(CAST(max_project_value AS DOUBLE))
      comment: "Average maximum project value approved for prequalified suppliers — measures the financial capacity ceiling of the qualified pool."
    - name: "total_max_project_value_capacity"
      expr: SUM(CAST(max_project_value AS DOUBLE))
      comment: "Total maximum project value capacity across all approved prequalifications — measures aggregate financial capacity of the qualified supplier pool."
    - name: "avg_minimum_passing_score"
      expr: AVG(CAST(minimum_passing_score AS DOUBLE))
      comment: "Average minimum passing score threshold across prequalification programmes — tracks qualification standard stringency."
    - name: "expiring_prequalification_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND prequalification_status = 'Approved' THEN prequalification_id END)
      comment: "Count of approved prequalifications expiring within 90 days — drives renewal pipeline management to prevent gaps in the eligible bidder pool."
$$;